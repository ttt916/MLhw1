close all;
clear all;
clc;

numTests=35;
sz = [192,168];
ssssd=0;
xxx=0;
numTrain = 35;
person=38;
trainData = zeros(prod(sz),numTrain,person);

a=fopen('te.txt');
C = textscan(a, '%s %s');
path0 = 'CroppedYale\';

for j =1:length(C{1})
     path = strcat(path0,C{1,1}{j},'\');
     addpath(path);
     image_name = dir([path '*.pgm']);
     for i=1:35
     img=imread(image_name(i).name);
      trainData(:,i,j) = img(:);
     end
end

numTest = 29;
testData = zeros(prod(sz),numTrain,person);
for j =1:length(C{1})
     path = strcat(path0,C{1,1}{j},'\');
     addpath(path);
     image_name = dir([path '*.pgm']);
     [x,y]=size(image_name);
     for i=36:x-1
     img=imread(image_name(i).name);
     img=double(img);
%      dd=repmat(img,38,35);
      testData(:,i-35,j) = img(:);
      xxx=xxx+1;
      
    
     end
end
trainClass = [5,2,5,2,5,2,1,2,4,3,2,5,3,3,5,2,4,4,2,3,1,1,3,4,5,1,3,3,1,2,1,4,2,3,1];
trainClass=trainClass';

for i=1:38
    for j=1:35
        ss=trainData(:,j,i);
        sss=repmat(ss,1,35);
        sssd=sum(abs(trainData(:,:,i)-sss));
        [sssd,idx] = sort(sssd, 2, 'ascend');    
        dd = mode(trainClass(idx),2);
             
%         prediction=prediction+dd;
    end
        for xx=1:35
            if dd(xx,1)==1
                 ssssd= ssssd+1;
            end
        end
end

sprintf('Accuracy=%f',ssssd/xxx)

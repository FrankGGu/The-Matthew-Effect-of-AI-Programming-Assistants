#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxNonOverlapping(int* nums, int numsSize, int target){
    int count = 0;
    int sum = 0;
    int start = -1;
    int end = -1;
    int *hash = (int*)malloc(sizeof(int) * (numsSize + 1));
    for(int i = 0; i <= numsSize; i++) {
        hash[i] = 0;
    }
    hash[0] = 1;
    for(int i = 0; i < numsSize; i++){
        sum += nums[i];
        int diff = sum - target;

        if(diff == 0){
            if(hash[0] == 1){
                count++;
                sum = 0;
                for(int j = 0; j <= numsSize; j++) {
                    hash[j] = 0;
                }
                hash[0] = 1;
            }
            else{

            }
        }
        else{
            int found = 0;
            int tempSum = 0;
            for(int j = 0; j <= i; j++){
                tempSum = 0;
                for(int k = j; k <= i; k++){
                    tempSum += nums[k];
                }
                if(tempSum == target){
                    int prevSum = sum - target;
                    int prevIndex = -1;
                    int tempSum2 = 0;
                    for(int l = 0; l < i; l++){
                        tempSum2 += nums[l];
                        if(tempSum2 == prevSum){
                            prevIndex = l;
                            break;
                        }
                    }

                    if(prevIndex == -1){
                        count++;
                        sum = 0;
                        for(int j = 0; j <= numsSize; j++) {
                            hash[j] = 0;
                        }
                        hash[0] = 1;
                        break;
                    }
                    else{

                    }
                }
            }

        }
        int tempSum3 = 0;
        for(int l = 0; l <= i; l++){
            tempSum3 += nums[l];

        }
        hash[sum] = 1;
    }

    int sum2 = 0;
    int count2 = 0;

    int *hash2 = (int*)malloc(sizeof(int) * (numsSize + 1));
    for(int i = 0; i <= numsSize; i++) {
        hash2[i] = 0;
    }
    hash2[0] = 1;

    for(int i = 0; i < numsSize; i++){
        sum2 += nums[i];
        int diff = sum2 - target;
        if(hash2[diff] == 1){
            count2++;
            sum2 = 0;
            for(int j = 0; j <= numsSize; j++) {
                hash2[j] = 0;
            }
            hash2[0] = 1;
        }
        hash2[sum2] = 1;
    }

    free(hash);
    free(hash2);
    return count2;
}
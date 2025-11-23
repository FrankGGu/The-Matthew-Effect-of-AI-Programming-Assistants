#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findIndices(int* nums, int numsSize, int indexDifference, int valueDifference, int* returnSize){
    for(int i = 0; i < numsSize; i++){
        for(int j = 0; j < numsSize; j++){
            if(abs(i - j) >= indexDifference && abs(nums[i] - nums[j]) >= valueDifference){
                int* result = (int*)malloc(2 * sizeof(int));
                result[0] = i;
                result[1] = j;
                *returnSize = 2;
                return result;
            }
        }
    }
    *returnSize = 0;
    return NULL;
}
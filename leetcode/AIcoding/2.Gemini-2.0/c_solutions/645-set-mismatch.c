#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findErrorNums(int* nums, int numsSize, int* returnSize){
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    int sum = 0;
    long long expectedSum = (long long)numsSize * (numsSize + 1) / 2;
    int duplicate = 0;
    int missing = 0;

    int count[numsSize + 1];
    for(int i = 0; i <= numsSize; i++){
        count[i] = 0;
    }

    for(int i = 0; i < numsSize; i++){
        sum += nums[i];
        count[nums[i]]++;
        if(count[nums[i]] > 1){
            duplicate = nums[i];
        }
    }

    missing = expectedSum - (sum - duplicate);

    result[0] = duplicate;
    result[1] = missing;

    return result;
}
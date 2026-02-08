#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long* findPrefixScore(int* nums, int numsSize, int* returnSize){
    long long *result = (long long*)malloc(numsSize * sizeof(long long));
    *returnSize = numsSize;

    int max_so_far = nums[0];
    long long prefix_score = nums[0] + max_so_far;
    result[0] = prefix_score;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > max_so_far) {
            max_so_far = nums[i];
        }
        prefix_score += nums[i] + max_so_far;
        result[i] = prefix_score;
    }

    return result;
}
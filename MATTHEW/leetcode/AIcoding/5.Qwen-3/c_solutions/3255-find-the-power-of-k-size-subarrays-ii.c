#include <stdio.h>
#include <stdlib.h>

int* findResults(int* nums, int numsSize, int k, int* returnSize) {
    int n = numsSize;
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    for (int i = 0; i < n; i++) {
        int maxVal = nums[i];
        int minVal = nums[i];
        for (int j = i; j < i + k && j < n; j++) {
            maxVal = (maxVal > nums[j]) ? maxVal : nums[j];
            minVal = (minVal < nums[j]) ? minVal : nums[j];
        }
        result[i] = maxVal - minVal;
    }

    return result;
}

int* resultsArray(int* nums, int numsSize, int k, int* returnSize) {
    return findResults(nums, numsSize, k, returnSize);
}
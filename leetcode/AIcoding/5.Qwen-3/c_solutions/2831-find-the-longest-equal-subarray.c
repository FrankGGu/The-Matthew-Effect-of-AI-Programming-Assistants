#include <stdio.h>
#include <stdlib.h>

int* longestEqualSubarray(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;
    int maxFreq = 0;
    int left = 0;
    int* count = (int*)calloc(10001, sizeof(int));

    for (int right = 0; right < numsSize; ++right) {
        count[nums[right]]++;
        maxFreq = fmax(maxFreq, count[nums[right]]);

        while (right - left + 1 - maxFreq > k) {
            count[nums[left]]--;
            left++;
        }
    }

    int start = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (count[nums[i]] == maxFreq) {
            start = i;
            break;
        }
    }

    result[0] = start;
    result[1] = start + maxFreq - 1;
    free(count);
    return result;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int solve(int* nums, int numsSize, int left, int right) {
    int xor_sum = 0;
    for (int i = left; i <= right; i++) {
        xor_sum ^= nums[i];
    }
    return xor_sum;
}

int* maxScoreSubarrayQueries(int* nums, int numsSize, int* queries, int queriesSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int k = queries[i];
        int max_score = 0;
        for (int j = 0; j < numsSize; j++) {
            for (int l = j; l < numsSize; l++) {
                int len = l - j + 1;
                if (len >= k) {
                    int xor_sum = solve(nums, numsSize, j, l);
                    max_score = max(max_score, xor_sum);
                }
            }
        }
        result[i] = max_score;
    }

    return result;
}
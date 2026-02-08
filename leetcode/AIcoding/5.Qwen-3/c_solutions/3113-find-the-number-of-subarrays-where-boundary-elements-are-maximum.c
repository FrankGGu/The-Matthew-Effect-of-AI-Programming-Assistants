#include <stdio.h>
#include <stdlib.h>

int* getAverages(int* nums, int numsSize, int k, int* returnSize) {
    int n = numsSize;
    *returnSize = 0;
    if (k == 0) {
        int* result = (int*)malloc(n * sizeof(int));
        for (int i = 0; i < n; i++) {
            result[i] = nums[i];
        }
        *returnSize = n;
        return result;
    }
    int windowSize = 2 * k + 1;
    if (windowSize > n) {
        return NULL;
    }
    int* result = (int*)malloc((n - windowSize + 1) * sizeof(int));
    int index = 0;
    for (int i = k; i <= n - k - 1; i++) {
        int max = nums[i];
        for (int j = i - k; j <= i + k; j++) {
            if (nums[j] > max) {
                max = nums[j];
            }
        }
        result[index++] = max;
    }
    *returnSize = index;
    return result;
}
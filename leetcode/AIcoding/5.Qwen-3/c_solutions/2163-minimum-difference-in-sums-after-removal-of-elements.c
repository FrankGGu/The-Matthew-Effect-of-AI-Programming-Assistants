#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

long long* getModifiedArray(int* nums, int numsSize, int* returnSize) {
    *returnSize = 0;
    if (numsSize == 0) return NULL;

    int n = numsSize;
    long long* prefix = (long long*)malloc(n * sizeof(long long));
    long long* suffix = (long long*)malloc(n * sizeof(long long));

    prefix[0] = nums[0];
    for (int i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }

    suffix[n - 1] = nums[n - 1];
    for (int i = n - 2; i >= 0; i--) {
        suffix[i] = suffix[i + 1] + nums[i];
    }

    int* sorted = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        sorted[i] = nums[i];
    }
    qsort(sorted, n, sizeof(int), compare);

    long long* result = (long long*)malloc(n * sizeof(long long));
    *returnSize = n;

    for (int i = 0; i < n; i++) {
        long long leftSum = (i == 0) ? 0 : prefix[i - 1];
        long long rightSum = (i == n - 1) ? 0 : suffix[i + 1];
        long long total = leftSum + rightSum;
        long long minDiff = 0;

        for (int j = 0; j < n; j++) {
            if (j == i) continue;
            long long sum1 = 0;
            long long sum2 = 0;
            for (int k = 0; k < n; k++) {
                if (k == i) continue;
                if (sorted[k] <= sorted[j]) {
                    sum1 += nums[k];
                } else {
                    sum2 += nums[k];
                }
            }
            minDiff = (minDiff == 0) ? abs(sum1 - sum2) : min(minDiff, abs(sum1 - sum2));
        }

        result[i] = minDiff;
    }

    free(prefix);
    free(suffix);
    free(sorted);
    return result;
}
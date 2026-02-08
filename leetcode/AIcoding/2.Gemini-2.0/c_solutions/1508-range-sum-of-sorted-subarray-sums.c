#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int rangeSum(int* nums, int numsSize, int n, int left, int right) {
    int* subsums = (int*)malloc(sizeof(int) * (n * (n + 1) / 2));
    int index = 0;
    for (int i = 0; i < numsSize; i++) {
        int currentSum = 0;
        for (int j = i; j < numsSize; j++) {
            currentSum += nums[j];
            subsums[index++] = currentSum;
        }
    }

    qsort(subsums, n * (n + 1) / 2, sizeof(int), compare);

    long long sum = 0;
    for (int i = left - 1; i < right; i++) {
        sum = (sum + subsums[i]) % 1000000007;
    }

    free(subsums);
    return (int)sum;
}
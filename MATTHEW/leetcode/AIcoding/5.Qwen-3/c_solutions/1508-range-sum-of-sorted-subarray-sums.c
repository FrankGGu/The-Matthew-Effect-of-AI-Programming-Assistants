#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long kthElement(int* nums, int numsSize, int k) {
    int n = numsSize;
    long long* subarraySums = (long long*)malloc(n * (n + 1) / 2 * sizeof(long long));
    int index = 0;

    for (int i = 0; i < n; i++) {
        long long sum = 0;
        for (int j = i; j < n; j++) {
            sum += nums[j];
            subarraySums[index++] = sum;
        }
    }

    qsort(subarraySums, index, sizeof(long long), compare);

    long long result = subarraySums[k - 1];
    free(subarraySums);
    return result;
}

long long rangeSum(int* nums, int numsSize, int l, int r) {
    int n = numsSize;
    long long* subarraySums = (long long*)malloc(n * (n + 1) / 2 * sizeof(long long));
    int index = 0;

    for (int i = 0; i < n; i++) {
        long long sum = 0;
        for (int j = i; j < n; j++) {
            sum += nums[j];
            subarraySums[index++] = sum;
        }
    }

    qsort(subarraySums, index, sizeof(long long), compare);

    long long total = 0;
    for (int i = l - 1; i < r; i++) {
        total += subarraySums[i];
    }

    free(subarraySums);
    return total;
}
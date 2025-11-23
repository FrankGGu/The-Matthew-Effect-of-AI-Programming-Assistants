#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

long long minOperations(int* nums, int numsSize, int* queries, int queriesSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    long long* result = (long long*)malloc(queriesSize * sizeof(long long));

    for (int i = 0; i < queriesSize; i++) {
        long long count = 0;
        for (int j = 0; j < numsSize; j++) {
            count += abs(nums[j] - queries[i]);
        }
        result[i] = count;
    }

    return *result;
}
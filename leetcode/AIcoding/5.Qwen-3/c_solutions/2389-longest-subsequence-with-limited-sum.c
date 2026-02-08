#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* answerQueries(int* nums, int numsSize, int* queries, int queriesSize, int* returnSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int* prefix = (int*)malloc(numsSize * sizeof(int));
    prefix[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }
    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int sum = 0;
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            sum += nums[j];
            if (sum > queries[i]) break;
            count++;
        }
        result[i] = count;
    }
    *returnSize = queriesSize;
    free(prefix);
    return result;
}
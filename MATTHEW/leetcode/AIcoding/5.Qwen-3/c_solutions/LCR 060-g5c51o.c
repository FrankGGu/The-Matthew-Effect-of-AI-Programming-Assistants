#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int num;
    int count;
} NumCount;

int compare(const void *a, const void *b) {
    NumCount *x = (NumCount *)a;
    NumCount *y = (NumCount *)b;
    return y->count - x->count;
}

int* topKFrequent(int* nums, int numsSize, int k, int* returnSize) {
    int maxNum = 0;
    int minNum = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxNum) maxNum = nums[i];
        if (nums[i] < minNum) minNum = nums[i];
    }

    int range = maxNum - minNum + 1;
    int *counts = (int *)calloc(range, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        counts[nums[i] - minNum]++;
    }

    NumCount *numCounts = (NumCount *)malloc(range * sizeof(NumCount));
    int index = 0;
    for (int i = 0; i < range; i++) {
        if (counts[i] > 0) {
            numCounts[index].num = i + minNum;
            numCounts[index].count = counts[i];
            index++;
        }
    }

    qsort(numCounts, index, sizeof(NumCount), compare);

    int *result = (int *)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = numCounts[i].num;
    }

    *returnSize = k;
    free(counts);
    free(numCounts);
    return result;
}
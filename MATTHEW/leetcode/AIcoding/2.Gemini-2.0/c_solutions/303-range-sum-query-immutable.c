#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *sums;
    int size;
} NumArray;

NumArray* numArrayCreate(int* nums, int numsSize) {
    NumArray* obj = (NumArray*)malloc(sizeof(NumArray));
    obj->sums = (int*)malloc((numsSize + 1) * sizeof(int));
    obj->size = numsSize;
    obj->sums[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        obj->sums[i + 1] = obj->sums[i] + nums[i];
    }
    return obj;
}

int numArraySumRange(NumArray* obj, int left, int right) {
    return obj->sums[right + 1] - obj->sums[left];
}

void numArrayFree(NumArray* obj) {
    free(obj->sums);
    free(obj);
}
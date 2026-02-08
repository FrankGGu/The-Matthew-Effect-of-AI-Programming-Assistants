#include <stdlib.h>

typedef struct {
    int* prefixSum;
    int size;
} NumArray;

NumArray* numArrayCreate(int* nums, int numsSize) {
    NumArray* obj = (NumArray*)malloc(sizeof(NumArray));
    if (obj == NULL) {
        return NULL;
    }

    obj->size = numsSize + 1;
    obj->prefixSum = (int*)malloc(sizeof(int) * obj->size);
    if (obj->prefixSum == NULL) {
        free(obj);
        return NULL;
    }

    obj->prefixSum[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        obj->prefixSum[i + 1] = obj->prefixSum[i] + nums[i];
    }

    return obj;
}

int numArraySumRange(NumArray* obj, int left, int right) {
    return obj->prefixSum[right + 1] - obj->prefixSum[left];
}

void numArrayFree(NumArray* obj) {
    if (obj != NULL) {
        free(obj->prefixSum);
        free(obj);
    }
}
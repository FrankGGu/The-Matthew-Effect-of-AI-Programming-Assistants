#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *nums;
    int *tree;
    int size;
} NumArray;

NumArray* numArrayCreate(int* nums, int numsSize) {
    NumArray* obj = (NumArray*)malloc(sizeof(NumArray));
    obj->nums = (int*)malloc(sizeof(int) * numsSize);
    obj->tree = (int*)malloc(sizeof(int) * (numsSize + 1));
    obj->size = numsSize;
    for (int i = 0; i < numsSize; i++) {
        obj->nums[i] = nums[i];
        obj->tree[i + 1] = obj->tree[i] + nums[i];
    }
    return obj;
}

void numArrayUpdate(NumArray* obj, int index, int val) {
    int diff = val - obj->nums[index];
    obj->nums[index] = val;
    for (int i = index + 1; i <= obj->size; i++) {
        obj->tree[i] += diff;
    }
}

int numArraySumRange(NumArray* obj, int left, int right) {
    return obj->tree[right + 1] - obj->tree[left];
}

void numArrayFree(NumArray* obj) {
    free(obj->nums);
    free(obj->tree);
    free(obj);
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *nums;
    int *bit;
    int n;
} NumArray;

int lowbit(int x) {
    return x & (-x);
}

void bit_update(int *bit, int i, int val, int n) {
    for (; i <= n; i += lowbit(i)) {
        bit[i] += val;
    }
}

int bit_query(int *bit, int i) {
    int sum = 0;
    for (; i > 0; i -= lowbit(i)) {
        sum += bit[i];
    }
    return sum;
}

NumArray* numArrayCreate(int* nums, int numsSize) {
    NumArray *obj = (NumArray*)malloc(sizeof(NumArray));
    obj->nums = (int*)malloc(sizeof(int) * numsSize);
    obj->bit = (int*)malloc(sizeof(int) * (numsSize + 1));
    obj->n = numsSize;

    for (int i = 0; i < numsSize; i++) {
        obj->nums[i] = nums[i];
        obj->bit[i + 1] = 0;
    }

    for (int i = 0; i < numsSize; i++) {
        bit_update(obj->bit, i + 1, nums[i], numsSize);
    }

    return obj;
}

void numArrayUpdate(NumArray* obj, int index, int val) {
    int diff = val - obj->nums[index];
    obj->nums[index] = val;
    bit_update(obj->bit, index + 1, diff, obj->n);
}

int numArraySumRange(NumArray* obj, int left, int right) {
    return bit_query(obj->bit, right + 1) - bit_query(obj->bit, left);
}

void numArrayFree(NumArray* obj) {
    free(obj->nums);
    free(obj->bit);
    free(obj);
}
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* nums;
    int* tree;
    int size;
} NumArray;

NumArray* numArrayCreate(int* nums, int numsSize) {
    NumArray* obj = (NumArray*)malloc(sizeof(NumArray));
    obj->size = numsSize;
    obj->nums = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        obj->nums[i] = nums[i];
    }
    int n = 1;
    while (n < numsSize) {
        n <<= 1;
    }
    obj->tree = (int*)calloc(n * 2, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        obj->tree[n + i] = nums[i];
    }
    for (int i = n - 1; i > 0; i--) {
        obj->tree[i] = obj->tree[2 * i] + obj->tree[2 * i + 1];
    }
    return obj;
}

void numArrayUpdate(NumArray* obj, int index, int val) {
    index += obj->size;
    obj->nums[index - obj->size] = val;
    obj->tree[index] = val;
    index >>= 1;
    while (index >= 1) {
        obj->tree[index] = obj->tree[2 * index] + obj->tree[2 * index + 1];
        index >>= 1;
    }
}

int numArraySumRange(NumArray* obj, int left, int right) {
    left += obj->size;
    right += obj->size;
    int sum = 0;
    while (left <= right) {
        if (left % 2 == 1) {
            sum += obj->tree[left];
            left++;
        }
        if (right % 2 == 0) {
            sum += obj->tree[right];
            right--;
        }
        left >>= 1;
        right >>= 1;
    }
    return sum;
}

void numArrayFree(NumArray* obj) {
    free(obj->nums);
    free(obj->tree);
    free(obj);
}
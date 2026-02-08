#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* nums;
    int n;
} Solution;

Solution* solutionCreate(int* nums, int numsSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->n = numsSize;
    obj->nums = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        obj->nums[i] = nums[i];
    }
    return obj;
}

void solutionUpdate(Solution* obj, int index, int value) {
    obj->nums[index] = value;
}

int solutionSum(Solution* obj, int left, int right) {
    int sum = 0;
    for (int i = left; i <= right; i++) {
        sum += obj->nums[i];
    }
    return sum;
}

void solutionFree(Solution* obj) {
    free(obj->nums);
    free(obj);
}
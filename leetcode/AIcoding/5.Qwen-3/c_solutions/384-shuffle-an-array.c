#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
    int* nums;
    int size;
} Solution;

Solution* solutionCreate(int* nums, int numsSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->nums = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        obj->nums[i] = nums[i];
    }
    obj->size = numsSize;
    return obj;
}

int* solutionShuffle(Solution* obj, int* returnSize) {
    int* result = (int*)malloc(obj->size * sizeof(int));
    for (int i = 0; i < obj->size; i++) {
        result[i] = obj->nums[i];
    }
    srand(time(NULL));
    for (int i = obj->size - 1; i > 0; i--) {
        int j = rand() % (i + 1);
        int temp = result[i];
        result[i] = result[j];
        result[j] = temp;
    }
    *returnSize = obj->size;
    return result;
}

void solutionFree(Solution* obj) {
    free(obj->nums);
    free(obj);
}
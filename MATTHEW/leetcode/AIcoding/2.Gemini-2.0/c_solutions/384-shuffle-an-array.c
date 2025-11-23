#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* nums;
    int* original;
    int size;
} Solution;

Solution* solutionCreate(int* nums, int numsSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->nums = (int*)malloc(numsSize * sizeof(int));
    obj->original = (int*)malloc(numsSize * sizeof(int));
    obj->size = numsSize;
    for (int i = 0; i < numsSize; i++) {
        obj->nums[i] = nums[i];
        obj->original[i] = nums[i];
    }
    srand(time(NULL));
    return obj;
}

int* solutionReset(Solution* obj, int* retSize) {
    *retSize = obj->size;
    for (int i = 0; i < obj->size; i++) {
        obj->nums[i] = obj->original[i];
    }
    return obj->nums;
}

int* solutionShuffle(Solution* obj, int* retSize) {
    *retSize = obj->size;
    for (int i = 0; i < obj->size; i++) {
        int j = i + rand() % (obj->size - i);
        int temp = obj->nums[i];
        obj->nums[i] = obj->nums[j];
        obj->nums[j] = temp;
    }
    return obj->nums;
}

void solutionFree(Solution* obj) {
    free(obj->nums);
    free(obj->original);
    free(obj);
}
#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* nums;
    int size;
} Solution;

Solution* solutionCreate(int* nums, int numsSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->nums = nums;
    obj->size = numsSize;
    return obj;
}

int solutionPick(Solution* obj) {
    int index = rand() % obj->size;
    return index;
}

void solutionFree(Solution* obj) {
    free(obj);
}
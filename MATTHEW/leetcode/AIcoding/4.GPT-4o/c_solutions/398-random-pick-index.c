#include <stdlib.h>

struct Solution {
    int* nums;
    int size;
};

struct Solution* solutionCreate(int* nums, int numsSize) {
    struct Solution* obj = (struct Solution*)malloc(sizeof(struct Solution));
    obj->nums = nums;
    obj->size = numsSize;
    return obj;
}

int solutionPickIndex(struct Solution* obj) {
    int index = rand() % obj->size;
    return index;
}

void solutionFree(struct Solution* obj) {
    free(obj);
}
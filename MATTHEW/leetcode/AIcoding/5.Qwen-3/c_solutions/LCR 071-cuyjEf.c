#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
    int* prefixSums;
    int size;
} Solution;

Solution* solutionCreate(int* nums, int numsSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->size = numsSize;
    obj->prefixSums = (int*)malloc(numsSize * sizeof(int));
    obj->prefixSums[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        obj->prefixSums[i] = obj->prefixSums[i - 1] + nums[i];
    }
    return obj;
}

int solutionPickIndex(Solution* obj) {
    int target = rand() % obj->prefixSums[obj->size - 1];
    int left = 0, right = obj->size - 1;
    while (left < right) {
        int mid = left + (right - left) / 2;
        if (obj->prefixSums[mid] <= target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}

void solutionFree(Solution* obj) {
    free(obj->prefixSums);
    free(obj);
}
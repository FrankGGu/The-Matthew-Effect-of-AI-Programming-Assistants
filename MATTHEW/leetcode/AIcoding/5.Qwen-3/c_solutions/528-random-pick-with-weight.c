#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
    int* w;
    int size;
    int* prefixSums;
} Solution;

Solution* solutionCreate(int* w, int wSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->w = w;
    obj->size = wSize;
    obj->prefixSums = (int*)malloc(wSize * sizeof(int));
    obj->prefixSums[0] = w[0];
    for (int i = 1; i < wSize; i++) {
        obj->prefixSums[i] = obj->prefixSums[i - 1] + w[i];
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
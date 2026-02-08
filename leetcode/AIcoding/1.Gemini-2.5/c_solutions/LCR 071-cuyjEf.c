#include <stdlib.h>
#include <time.h>

typedef struct {
    int* prefixSums;
    int wSize;
    int totalSum;
} Solution;

Solution* solutionCreate(int* w, int wSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->wSize = wSize;
    obj->prefixSums = (int*)malloc(sizeof(int) * wSize);

    obj->prefixSums[0] = w[0];
    for (int i = 1; i < wSize; i++) {
        obj->prefixSums[i] = obj->prefixSums[i - 1] + w[i];
    }
    obj->totalSum = obj->prefixSums[wSize - 1];

    srand(time(NULL)); // Initialize random seed once

    return obj;
}

int solutionPickIndex(Solution* obj) {
    // Generate a random number from 1 to totalSum (inclusive)
    int target = (rand() % obj->totalSum) + 1;

    // Binary search to find the first index i such that prefixSums[i] >= target
    int left = 0;
    int right = obj->wSize - 1;
    int mid;

    while (left < right) {
        mid = left + (right - left) / 2;
        if (obj->prefixSums[mid] < target) {
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
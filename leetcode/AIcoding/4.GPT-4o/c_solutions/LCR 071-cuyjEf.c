#include <stdlib.h>

typedef struct {
    int* prefixSums;
    int totalWeight;
} Solution;

Solution* solutionCreate(int* w, int wSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->prefixSums = (int*)malloc(wSize * sizeof(int));
    obj->prefixSums[0] = w[0];
    for (int i = 1; i < wSize; i++) {
        obj->prefixSums[i] = obj->prefixSums[i - 1] + w[i];
    }
    obj->totalWeight = obj->prefixSums[wSize - 1];
    return obj;
}

int solutionPickIndex(Solution* obj) {
    int target = rand() % obj->totalWeight;
    int left = 0, right = sizeof(obj->prefixSums) / sizeof(obj->prefixSums[0]) - 1;
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
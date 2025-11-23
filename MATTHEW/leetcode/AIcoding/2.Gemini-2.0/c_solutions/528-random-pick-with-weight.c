#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *prefix_sums;
    int total_sum;
    int w_size;
} Solution;

Solution* solutionCreate(int* w, int wSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->prefix_sums = (int*)malloc(sizeof(int) * wSize);
    obj->w_size = wSize;
    obj->total_sum = 0;
    for (int i = 0; i < wSize; i++) {
        obj->total_sum += w[i];
        obj->prefix_sums[i] = obj->total_sum;
    }
    srand(time(NULL));
    return obj;
}

int solutionPickIndex(Solution* obj) {
    int target = rand() % obj->total_sum;
    int low = 0;
    int high = obj->w_size - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (obj->prefix_sums[mid] <= target) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return low;
}

void solutionFree(Solution* obj) {
    free(obj->prefix_sums);
    free(obj);
}
#include <stdlib.h>
#include <time.h>

typedef struct {
    int* prefixSums;
    int size;
    int totalSum;
} Solution;

Solution* solutionCreate(int* w, int wSize) {
    srand(time(NULL));

    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->size = wSize;
    obj->prefixSums = (int*)malloc(sizeof(int) * wSize);

    obj->totalSum = 0;
    for (int i = 0; i < wSize; ++i) {
        obj->totalSum += w[i];
        obj->prefixSums[i] = obj->totalSum;
    }

    return obj;
}

int solutionPickIndex(Solution* obj) {
    int target = rand() % obj->totalSum + 1;

    int low = 0;
    int high = obj->size - 1;
    int ans = -1;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (obj->prefixSums[mid] >= target) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
}

void solutionFree(Solution* obj) {
    free(obj->prefixSums);
    free(obj);
}
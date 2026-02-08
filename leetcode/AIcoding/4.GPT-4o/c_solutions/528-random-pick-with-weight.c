typedef struct {
    int* prefixSums;
    int totalWeight;
    int size;
} Solution;

Solution* solutionCreate(int* w, int wSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->prefixSums = (int*)malloc(sizeof(int) * wSize);
    obj->totalWeight = 0;
    obj->size = wSize;

    for (int i = 0; i < wSize; i++) {
        obj->totalWeight += w[i];
        obj->prefixSums[i] = obj->totalWeight;
    }

    return obj;
}

int solutionPickIndex(Solution* obj) {
    int target = rand() % obj->totalWeight;
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
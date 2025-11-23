typedef struct {
    int* prefixSums;
    int total;
    int size;
} Solution;

Solution* solutionCreate(int* w, int wSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->prefixSums = (int*)malloc(wSize * sizeof(int));
    obj->size = wSize;

    int prefixSum = 0;
    for (int i = 0; i < wSize; i++) {
        prefixSum += w[i];
        obj->prefixSums[i] = prefixSum;
    }
    obj->total = prefixSum;

    return obj;
}

int solutionPickIndex(Solution* obj) {
    float target = (float)rand() / RAND_MAX * obj->total;

    int left = 0, right = obj->size - 1;
    while (left < right) {
        int mid = left + (right - left) / 2;
        if (target > obj->prefixSums[mid]) {
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

/**
 * Your Solution struct will be instantiated and called as such:
 * Solution* obj = solutionCreate(w, wSize);
 * int param_1 = solutionPickIndex(obj);

 * solutionFree(obj);
*/
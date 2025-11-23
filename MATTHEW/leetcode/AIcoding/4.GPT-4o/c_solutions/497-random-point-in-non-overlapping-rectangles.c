typedef struct {
    int** rects;
    int* prefixSums;
    int total;
    int size;
} Solution;

Solution* solutionCreate(int** rects, int rectsSize, int* rectsColSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->rects = rects;
    obj->prefixSums = (int*)malloc(rectsSize * sizeof(int));
    obj->total = 0;
    obj->size = rectsSize;

    for (int i = 0; i < rectsSize; i++) {
        int width = rects[i][2] - rects[i][0] + 1;
        int height = rects[i][3] - rects[i][1] + 1;
        obj->total += width * height;
        obj->prefixSums[i] = obj->total;
    }
    return obj;
}

int* solutionPick(Solution* obj) {
    int target = rand() % obj->total;
    int left = 0, right = obj->size - 1;

    while (left < right) {
        int mid = left + (right - left) / 2;
        if (obj->prefixSums[mid] <= target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    int rectIndex = left;
    int width = obj->rects[rectIndex][2] - obj->rects[rectIndex][0] + 1;
    int height = obj->rects[rectIndex][3] - obj->rects[rectIndex][1] + 1;

    int x = obj->rects[rectIndex][0] + (rand() % width);
    int y = obj->rects[rectIndex][1] + (rand() % height);

    int* point = (int*)malloc(2 * sizeof(int));
    point[0] = x;
    point[1] = y;
    return point;
}

void solutionFree(Solution* obj) {
    free(obj->prefixSums);
    free(obj);
}
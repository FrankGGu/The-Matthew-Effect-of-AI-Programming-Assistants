typedef struct {
    int left;
    int right;
    int height;
} Interval;

int max(int a, int b) {
    return a > b ? a : b;
}

int* fallingSquares(int** positions, int positionsSize, int* positionsColSize, int* returnSize) {
    Interval* intervals = (Interval*)malloc(positionsSize * sizeof(Interval));
    int* res = (int*)malloc(positionsSize * sizeof(int));
    int maxHeight = 0;

    for (int i = 0; i < positionsSize; i++) {
        int left = positions[i][0];
        int size = positions[i][1];
        int right = left + size;
        int currentHeight = size;

        for (int j = 0; j < i; j++) {
            if (intervals[j].right > left && intervals[j].left < right) {
                currentHeight = max(currentHeight, intervals[j].height + size);
            }
        }

        intervals[i].left = left;
        intervals[i].right = right;
        intervals[i].height = currentHeight;

        maxHeight = max(maxHeight, currentHeight);
        res[i] = maxHeight;
    }

    *returnSize = positionsSize;
    free(intervals);
    return res;
}
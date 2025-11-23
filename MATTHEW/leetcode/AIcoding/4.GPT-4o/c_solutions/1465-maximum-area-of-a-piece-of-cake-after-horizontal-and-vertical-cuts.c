#define MOD 1000000007

int maxArea(int h, int w, int* horizontalCuts, int horizontalCutsSize, int* verticalCuts, int verticalCutsSize) {
    qsort(horizontalCuts, horizontalCutsSize, sizeof(int), cmp);
    qsort(verticalCuts, verticalCutsSize, sizeof(int), cmp);

    long maxH = horizontalCuts[0];
    for (int i = 1; i < horizontalCutsSize; i++) {
        maxH = fmax(maxH, horizontalCuts[i] - horizontalCuts[i - 1]);
    }
    maxH = fmax(maxH, h - horizontalCuts[horizontalCutsSize - 1]);

    long maxW = verticalCuts[0];
    for (int i = 1; i < verticalCutsSize; i++) {
        maxW = fmax(maxW, verticalCuts[i] - verticalCuts[i - 1]);
    }
    maxW = fmax(maxW, w - verticalCuts[verticalCutsSize - 1]);

    return (maxH * maxW) % MOD;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}
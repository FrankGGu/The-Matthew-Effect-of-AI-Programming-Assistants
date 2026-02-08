#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

#define MAX(a, b) ((a) > (b) ? (a) : (b))

int maxArea(int h, int w, int* horizontalCuts, int horizontalCutsSize, int* verticalCuts, int verticalCutsSize) {
    qsort(horizontalCuts, horizontalCutsSize, sizeof(int), compare);
    qsort(verticalCuts, verticalCutsSize, sizeof(int), compare);

    long long max_h_diff = 0;
    int prev_h_cut = 0;

    for (int i = 0; i < horizontalCutsSize; i++) {
        max_h_diff = MAX(max_h_diff, (long long)horizontalCuts[i] - prev_h_cut);
        prev_h_cut = horizontalCuts[i];
    }
    max_h_diff = MAX(max_h_diff, (long long)h - prev_h_cut);

    long long max_w_diff = 0;
    int prev_w_cut = 0;

    for (int i = 0; i < verticalCutsSize; i++) {
        max_w_diff = MAX(max_w_diff, (long long)verticalCuts[i] - prev_w_cut);
        prev_w_cut = verticalCuts[i];
    }
    max_w_diff = MAX(max_w_diff, (long long)w - prev_w_cut);

    long long result = max_h_diff * max_w_diff;
    long long modulo = 1000000000 + 7;

    return (int)(result % modulo);
}
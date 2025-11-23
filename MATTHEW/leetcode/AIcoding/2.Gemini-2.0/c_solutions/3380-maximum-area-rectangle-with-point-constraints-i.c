#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxArea(int n, int m, int** hBars, int hBarsSize, int* hBarsColSize, int** vBars, int vBarsSize, int* vBarsColSize) {
    int max_area = 0;
    int* horizontal_bars = (int*)malloc(sizeof(int) * (hBarsSize + 2));
    int* vertical_bars = (int*)malloc(sizeof(int) * (vBarsSize + 2));

    horizontal_bars[0] = 0;
    horizontal_bars[hBarsSize + 1] = m;
    for (int i = 0; i < hBarsSize; i++) {
        horizontal_bars[i + 1] = hBars[i][0];
    }

    vertical_bars[0] = 0;
    vertical_bars[vBarsSize + 1] = n;
    for (int i = 0; i < vBarsSize; i++) {
        vertical_bars[i + 1] = vBars[i][0];
    }

    qsort(horizontal_bars, hBarsSize + 2, sizeof(int), compare);
    qsort(vertical_bars, vBarsSize + 2, sizeof(int), compare);

    int max_width = 0;
    for (int i = 1; i < hBarsSize + 2; i++) {
        int width = horizontal_bars[i] - horizontal_bars[i - 1];
        if (width > max_width) {
            max_width = width;
        }
    }

    int max_height = 0;
    for (int i = 1; i < vBarsSize + 2; i++) {
        int height = vertical_bars[i] - vertical_bars[i - 1];
        if (height > max_height) {
            max_height = height;
        }
    }

    max_area = max_width * max_height;

    free(horizontal_bars);
    free(vertical_bars);

    return max_area;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}
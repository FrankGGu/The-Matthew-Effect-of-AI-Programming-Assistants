#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxArea(int n, int m, int* hBars, int hBarsSize, int* vBars, int vBarsSize) {
    int maxH = 1;
    int currH = 1;
    qsort(hBars, hBarsSize, sizeof(int), cmp);
    for (int i = 1; i < hBarsSize; i++) {
        if (hBars[i] == hBars[i - 1] + 1) {
            currH++;
        } else {
            maxH = fmax(maxH, currH);
            currH = 1;
        }
    }
    maxH = fmax(maxH, currH);

    int maxV = 1;
    int currV = 1;
    qsort(vBars, vBarsSize, sizeof(int), cmp);
    for (int i = 1; i < vBarsSize; i++) {
        if (vBars[i] == vBars[i - 1] + 1) {
            currV++;
        } else {
            maxV = fmax(maxV, currV);
            currV = 1;
        }
    }
    maxV = fmax(maxV, currV);

    int side = fmin(maxH + 1, maxV + 1);
    return side * side;
}

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}
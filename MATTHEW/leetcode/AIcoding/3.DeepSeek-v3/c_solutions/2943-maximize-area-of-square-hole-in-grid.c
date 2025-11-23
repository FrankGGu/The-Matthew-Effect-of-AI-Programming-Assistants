#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int maximizeSquareHoleArea(int n, int m, int* hBars, int hBarsSize, int* vBars, int vBarsSize) {
    qsort(hBars, hBarsSize, sizeof(int), cmp);
    qsort(vBars, vBarsSize, sizeof(int), cmp);

    int maxH = 1, maxV = 1;
    int cnt = 1;

    for (int i = 1; i < hBarsSize; i++) {
        if (hBars[i] == hBars[i-1] + 1) {
            cnt++;
        } else {
            cnt = 1;
        }
        if (cnt + 1 > maxH) {
            maxH = cnt + 1;
        }
    }

    cnt = 1;
    for (int i = 1; i < vBarsSize; i++) {
        if (vBars[i] == vBars[i-1] + 1) {
            cnt++;
        } else {
            cnt = 1;
        }
        if (cnt + 1 > maxV) {
            maxV = cnt + 1;
        }
    }

    int side = maxH < maxV ? maxH : maxV;
    return side * side;
}
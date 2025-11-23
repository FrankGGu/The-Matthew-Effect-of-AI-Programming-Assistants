#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxArea(int n, int m, int* hFences, int hFencesSize, int* vFences, int vFencesSize) {
    int h[hFencesSize + 2];
    int v[vFencesSize + 2];

    h[0] = 1;
    for (int i = 0; i < hFencesSize; i++) {
        h[i + 1] = hFences[i];
    }
    h[hFencesSize + 1] = n;

    v[0] = 1;
    for (int i = 0; i < vFencesSize; i++) {
        v[i + 1] = vFences[i];
    }
    v[vFencesSize + 1] = m;

    qsort(h, hFencesSize + 2, sizeof(int), cmp);
    qsort(v, vFencesSize + 2, sizeof(int), cmp);

    int hDiff[hFencesSize * (hFencesSize + 1) / 2 + hFencesSize + 1];
    int vDiff[vFencesSize * (vFencesSize + 1) / 2 + vFencesSize + 1];

    int hDiffSize = 0;
    for (int i = 0; i < hFencesSize + 2; i++) {
        for (int j = i + 1; j < hFencesSize + 2; j++) {
            hDiff[hDiffSize++] = h[j] - h[i];
        }
    }

    int vDiffSize = 0;
    for (int i = 0; i < vFencesSize + 2; i++) {
        for (int j = i + 1; j < vFencesSize + 2; j++) {
            vDiff[vDiffSize++] = v[j] - v[i];
        }
    }

    long long max_area = -1;

    for (int i = 0; i < hDiffSize; i++) {
        for (int j = 0; j < vDiffSize; j++) {
            if (hDiff[i] == vDiff[j]) {
                long long side = (long long)hDiff[i];
                if (max_area == -1 || side * side < max_area) {
                    max_area = (max_area == -1) ? side * side : (side * side > max_area) ? max_area : side * side;
                }
                else
                {
                    max_area = (max_area == -1) ? side * side : max_area;
                }
            }
        }
    }

    if(max_area == -1) return -1;
    return (int)(max_area % 1000000007);
}
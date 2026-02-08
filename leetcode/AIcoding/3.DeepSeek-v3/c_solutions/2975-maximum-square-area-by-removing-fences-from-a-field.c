#include <stdlib.h>
#include <string.h>

int maximizeSquareArea(int m, int n, int* hFences, int hFencesSize, int* vFences, int vFencesSize) {
    long long MOD = 1000000007;

    int* h = (int*)malloc((hFencesSize + 2) * sizeof(int));
    h[0] = 1;
    h[hFencesSize + 1] = m;
    for (int i = 0; i < hFencesSize; i++) {
        h[i + 1] = hFences[i];
    }
    int hSize = hFencesSize + 2;

    int* v = (int*)malloc((vFencesSize + 2) * sizeof(int));
    v[0] = 1;
    v[vFencesSize + 1] = n;
    for (int i = 0; i < vFencesSize; i++) {
        v[i + 1] = vFences[i];
    }
    int vSize = vFencesSize + 2;

    int* hDiffs = (int*)malloc(hSize * hSize * sizeof(int));
    int hDiffCount = 0;
    for (int i = 0; i < hSize; i++) {
        for (int j = i + 1; j < hSize; j++) {
            hDiffs[hDiffCount++] = abs(h[i] - h[j]);
        }
    }

    int* vDiffs = (int*)malloc(vSize * vSize * sizeof(int));
    int vDiffCount = 0;
    for (int i = 0; i < vSize; i++) {
        for (int j = i + 1; j < vSize; j++) {
            vDiffs[vDiffCount++] = abs(v[i] - v[j]);
        }
    }

    int maxSide = -1;
    for (int i = 0; i < hDiffCount; i++) {
        for (int j = 0; j < vDiffCount; j++) {
            if (hDiffs[i] == vDiffs[j]) {
                if (hDiffs[i] > maxSide) {
                    maxSide = hDiffs[i];
                }
            }
        }
    }

    free(h);
    free(v);
    free(hDiffs);
    free(vDiffs);

    if (maxSide == -1) {
        return -1;
    }
    return (long long)maxSide * maxSide % MOD;
}
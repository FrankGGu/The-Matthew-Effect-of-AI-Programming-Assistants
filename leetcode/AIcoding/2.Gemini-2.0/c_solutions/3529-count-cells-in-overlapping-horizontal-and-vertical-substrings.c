#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCells(int n, int m, int hLength, int vLength, int *horizontal, int horizontalSize, int *vertical, int verticalSize) {
    int hCount[n];
    int vCount[m];
    memset(hCount, 0, sizeof(hCount));
    memset(vCount, 0, sizeof(vCount));

    for (int i = 0; i < horizontalSize; i++) {
        for (int j = horizontal[i]; j < horizontal[i] + hLength && j < n; j++) {
            hCount[j]++;
        }
    }

    for (int i = 0; i < verticalSize; i++) {
        for (int j = vertical[i]; j < vertical[i] + vLength && j < m; j++) {
            vCount[j]++;
        }
    }

    int ans = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (hCount[i] > 0 && vCount[j] > 0) {
                ans++;
            }
        }
    }

    return ans;
}
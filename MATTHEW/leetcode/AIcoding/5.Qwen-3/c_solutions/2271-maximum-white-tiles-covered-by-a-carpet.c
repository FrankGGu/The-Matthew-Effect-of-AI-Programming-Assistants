#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return x[0] - y[0];
}

int maximumWhiteTiles(int** tiles, int tilesSize, int* tilesColSize, int carpetLen) {
    qsort(tiles, tilesSize, sizeof(int*), compare);

    int res = 0;
    int i = 0;
    int covered = 0;

    while (i < tilesSize) {
        int start = tiles[i][0];
        int end = tiles[i][1];

        if (start + carpetLen <= end) {
            res += carpetLen;
            break;
        } else {
            covered += end - start + 1;
            if (i + 1 < tilesSize) {
                int nextStart = tiles[i + 1][0];
                if (nextStart > start + carpetLen) {
                    res = covered;
                    break;
                }
            }
            i++;
        }
    }

    return res;
}
#include <stdio.h>
#include <stdlib.h>

int minCostToMoveTiles(int* tiles, int tilesSize) {
    int* count = (int*)calloc(100, sizeof(int));
    for (int i = 0; i < tilesSize; i++) {
        count[tiles[i]]++;
    }
    int res = 0;
    int pos = 0;
    for (int i = 0; i < 100; i++) {
        if (count[i] == 0) continue;
        res += count[i] * (i - pos);
        pos = i;
    }
    return res;
}
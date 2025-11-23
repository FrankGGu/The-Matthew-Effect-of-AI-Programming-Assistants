#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return ((int*)a)[0] - ((int*)b)[0];
}

int maximumWhiteTiles(int** tiles, int tilesSize, int* tilesColSize, int carpetLen) {
    qsort(tiles, tilesSize, sizeof(tiles[0]), compare);
    int maxTiles = 0;
    int i = 0, j = 0;
    int covered = 0;
    while (i < tilesSize) {
        while (j < tilesSize && tiles[j][1] < tiles[i][0] + carpetLen) {
            covered += tiles[j][1] - tiles[j][0] + 1;
            j++;
        }
        int currentTiles = covered;
        if (j < tilesSize && tiles[i][0] + carpetLen > tiles[j][0]) {
            currentTiles += tiles[i][0] + carpetLen - tiles[j][0];
        }
        maxTiles = maxTiles > currentTiles ? maxTiles : currentTiles;
        covered -= tiles[i][1] - tiles[i][0] + 1;
        i++;
    }
    return maxTiles;
}
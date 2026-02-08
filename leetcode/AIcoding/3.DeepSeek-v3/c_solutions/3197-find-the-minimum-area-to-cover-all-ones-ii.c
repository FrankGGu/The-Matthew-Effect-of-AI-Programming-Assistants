#include <stdlib.h>
#include <string.h>

int minArea(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int minX = m, maxX = -1, minY = n, maxY = -1;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == '1') {
                if (i < minX) minX = i;
                if (i > maxX) maxX = i;
                if (j < minY) minY = j;
                if (j > maxY) maxY = j;
            }
        }
    }

    if (maxX == -1) return 0;

    int width = maxY - minY + 1;
    int height = maxX - minX + 1;

    return width * height;
}
#include <stdio.h>
#include <stdlib.h>

int countExtractable(int** artifacts, int artifactsSize, int* artifactsColSizes, int** dig, int digSize, int* digColSizes) {
    int* grid = (int*)calloc(101 * 101, sizeof(int));
    for (int i = 0; i < digSize; i++) {
        int x = dig[i][0];
        int y = dig[i][1];
        grid[x * 101 + y] = 1;
    }
    int count = 0;
    for (int i = 0; i < artifactsSize; i++) {
        int x1 = artifacts[i][0];
        int y1 = artifacts[i][1];
        int x2 = artifacts[i][2];
        int y2 = artifacts[i][3];
        int flag = 1;
        for (int x = x1; x <= x2; x++) {
            for (int y = y1; y <= y2; y++) {
                if (grid[x * 101 + y] != 1) {
                    flag = 0;
                    break;
                }
            }
            if (!flag) break;
        }
        if (flag) count++;
    }
    free(grid);
    return count;
}
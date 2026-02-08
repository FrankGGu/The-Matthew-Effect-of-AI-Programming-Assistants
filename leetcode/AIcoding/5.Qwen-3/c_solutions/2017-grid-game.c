#include <stdio.h>
#include <stdlib.h>

long long gridGame(int** grid, int gridSize, int* gridColSize) {
    int n = gridColSize[0];
    long long top = 0, bottom = 0;
    for (int i = 0; i < n; i++) {
        top += grid[0][i];
    }
    for (int i = 0; i < n; i++) {
        bottom += grid[1][i];
    }
    long long res = -1;
    for (int i = 0; i < n; i++) {
        long long upper = top - grid[0][i];
        long long lower = bottom - grid[1][i];
        long long curr = (upper > lower) ? upper : lower;
        if (res == -1 || curr < res) {
            res = curr;
        }
    }
    return res;
}
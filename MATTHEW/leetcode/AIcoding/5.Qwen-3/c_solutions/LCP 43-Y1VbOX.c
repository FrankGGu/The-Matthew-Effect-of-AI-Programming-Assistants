#include <stdio.h>
#include <stdlib.h>

int trafficCommand(int** road, int roadSize, int* roadColSize) {
    int n = roadSize;
    int m = roadColSize[0];
    int** grid = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        grid[i] = (int*)malloc(m * sizeof(int));
        for (int j = 0; j < m; j++) {
            grid[i][j] = road[i][j];
        }
    }

    int** directions = (int**)malloc(4 * sizeof(int*));
    directions[0] = (int*)malloc(2 * sizeof(int)); directions[0][0] = -1; directions[0][1] = 0;
    directions[1] = (int*)malloc(2 * sizeof(int)); directions[1][0] = 1; directions[1][1] = 0;
    directions[2] = (int*)malloc(2 * sizeof(int)); directions[2][0] = 0; directions[2][1] = -1;
    directions[3] = (int*)malloc(2 * sizeof(int)); directions[3][0] = 0; directions[3][1] = 1;

    int result = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 1) {
                int count = 0;
                for (int d = 0; d < 4; d++) {
                    int ni = i + directions[d][0];
                    int nj = j + directions[d][1];
                    if (ni >= 0 && ni < n && nj >= 0 && nj < m && grid[ni][nj] == 1) {
                        count++;
                    }
                }
                if (count == 2) {
                    result++;
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(grid[i]);
    }
    free(grid);
    for (int i = 0; i < 4; i++) {
        free(directions[i]);
    }
    free(directions);

    return result;
}
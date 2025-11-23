#include <stdio.h>
#include <stdlib.h>

int countUnguarded(int m, int n, int** guards, int guardsSize, int* guardsColSize, int** walls, int wallsSize, int* wallsColSize) {
    int** grid = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        grid[i] = (int*)calloc(n, sizeof(int));
    }

    for (int i = 0; i < guardsSize; i++) {
        int x = guards[i][0];
        int y = guards[i][1];
        grid[x][y] = 2; // guard
    }

    for (int i = 0; i < wallsSize; i++) {
        int x = walls[i][0];
        int y = walls[i][1];
        grid[x][y] = 3; // wall
    }

    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    for (int i = 0; i < guardsSize; i++) {
        int x = guards[i][0];
        int y = guards[i][1];
        for (int d = 0; d < 4; d++) {
            int dx = directions[d][0];
            int dy = directions[d][1];
            int nx = x + dx;
            int ny = y + dy;
            while (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                if (grid[nx][ny] == 3) break;
                if (grid[nx][ny] == 0) {
                    grid[nx][ny] = 1; // guarded
                }
                nx += dx;
                ny += dy;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 0) count++;
        }
    }

    for (int i = 0; i < m; i++) {
        free(grid[i]);
    }
    free(grid);

    return count;
}
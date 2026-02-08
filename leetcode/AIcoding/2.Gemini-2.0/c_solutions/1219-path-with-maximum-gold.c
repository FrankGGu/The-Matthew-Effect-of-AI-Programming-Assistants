#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getMaximumGold(int** grid, int gridSize, int* gridColSize){
    int maxGold = 0;
    int m = gridSize;
    int n = gridColSize[0];
    bool visited[m][n];
    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    void dfs(int x, int y, int currentGold) {
        currentGold += grid[x][y];
        visited[x][y] = true;

        if (currentGold > maxGold) {
            maxGold = currentGold;
        }

        for (int i = 0; i < 4; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] != 0 && !visited[nx][ny]) {
                dfs(nx, ny, currentGold);
            }
        }

        visited[x][y] = false;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] != 0) {
                for (int x = 0; x < m; x++) {
                    for (int y = 0; y < n; y++) {
                        visited[x][y] = false;
                    }
                }
                dfs(i, j, 0);
            }
        }
    }

    return maxGold;
}
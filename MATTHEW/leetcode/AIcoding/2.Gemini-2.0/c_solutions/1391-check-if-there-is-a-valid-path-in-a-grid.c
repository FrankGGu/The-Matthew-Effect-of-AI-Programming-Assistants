#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool hasValidPath(int** grid, int gridSize, int* gridColSize){
    int m = gridSize;
    int n = gridColSize[0];
    bool visited[m][n];
    memset(visited, false, sizeof(visited));

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    int street_directions[7][4][2] = {
        {{0, 1}, {0, -1}},
        {{-1, 0}, {1, 0}},
        {{0, -1}, {1, 0}},
        {{0, 1}, {1, 0}},
        {{0, -1}, {-1, 0}},
        {{0, 1}, {-1, 0}}
    };

    bool isValid(int x, int y) {
        return x >= 0 && x < m && y >= 0 && y < n && !visited[x][y];
    }

    bool dfs(int x, int y) {
        if (x == m - 1 && y == n - 1) {
            return true;
        }

        visited[x][y] = true;

        int street_type = grid[x][y] - 1;
        for (int i = 0; i < 2; i++) {
            int nx = x + street_directions[street_type][i][0];
            int ny = y + street_directions[street_type][i][1];

            if (isValid(nx, ny)) {
                int next_street_type = grid[nx][ny] - 1;
                for (int j = 0; j < 2; j++) {
                    if (nx + street_directions[next_street_type][j][0] == x && ny + street_directions[next_street_type][j][1] == y) {
                        if (dfs(nx, ny)) {
                            return true;
                        }
                        break;
                    }
                }
            }
        }

        return false;
    }

    return dfs(0, 0);
}
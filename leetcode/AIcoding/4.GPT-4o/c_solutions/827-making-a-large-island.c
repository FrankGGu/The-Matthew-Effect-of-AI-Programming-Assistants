#define MAX 100
int directions[4][2] = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};

void dfs(int** grid, int x, int y, int n, int* area, int index) {
    if (x < 0 || x >= n || y < 0 || y >= n || grid[x][y] != 1) return;
    grid[x][y] = index;
    (*area)++;
    for (int i = 0; i < 4; i++) {
        dfs(grid, x + directions[i][0], y + directions[i][1], n, area, index);
    }
}

int largestIsland(int** grid, int gridSize, int* gridColSize) {
    int maxArea = 0, index = 2;
    int area[MAX * MAX] = {0};
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == 1) {
                int currentArea = 0;
                dfs(grid, i, j, gridSize, &currentArea, index);
                area[index++] = currentArea;
                maxArea = maxArea > currentArea ? maxArea : currentArea;
            }
        }
    }
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == 0) {
                int newArea = 1;
                int seen[MAX] = {0};
                for (int d = 0; d < 4; d++) {
                    int nx = i + directions[d][0], ny = j + directions[d][1];
                    if (nx >= 0 && nx < gridSize && ny >= 0 && ny < gridColSize[nx]) {
                        int idx = grid[nx][ny];
                        if (idx > 1 && !seen[idx]) {
                            newArea += area[idx];
                            seen[idx] = 1;
                        }
                    }
                }
                maxArea = maxArea > newArea ? maxArea : newArea;
            }
        }
    }
    return maxArea > 0 ? maxArea : gridSize * gridSize;
}
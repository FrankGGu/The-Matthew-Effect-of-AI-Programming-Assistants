int d[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

int dfs(int** grid, int n, int x, int y, int index) {
    if (x < 0 || x >= n || y < 0 || y >= n || grid[x][y] != 1) {
        return 0;
    }
    grid[x][y] = index;
    int count = 1;
    for (int i = 0; i < 4; i++) {
        count += dfs(grid, n, x + d[i][0], y + d[i][1], index);
    }
    return count;
}

int largestIsland(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int* area = (int*)malloc((n * n + 2) * sizeof(int));
    memset(area, 0, (n * n + 2) * sizeof(int));
    int index = 2;
    int maxArea = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                area[index] = dfs(grid, n, i, j, index);
                maxArea = maxArea > area[index] ? maxArea : area[index];
                index++;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 0) {
                int sum = 1;
                int seen[4] = {0};
                int count = 0;
                for (int k = 0; k < 4; k++) {
                    int ni = i + d[k][0];
                    int nj = j + d[k][1];
                    if (ni >= 0 && ni < n && nj >= 0 && nj < n && grid[ni][nj] > 1) {
                        int idx = grid[ni][nj];
                        int found = 0;
                        for (int m = 0; m < count; m++) {
                            if (seen[m] == idx) {
                                found = 1;
                                break;
                            }
                        }
                        if (!found) {
                            seen[count++] = idx;
                            sum += area[idx];
                        }
                    }
                }
                maxArea = maxArea > sum ? maxArea : sum;
            }
        }
    }

    free(area);
    return maxArea;
}
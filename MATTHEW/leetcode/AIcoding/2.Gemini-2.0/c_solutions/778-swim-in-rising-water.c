#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int swimInWater(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int low = grid[0][0], high = n * n - 1;
    int ans = high;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        bool visited[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                visited[i][j] = false;
            }
        }

        bool dfs(int r, int c) {
            if (r < 0 || r >= n || c < 0 || c >= n || visited[r][c] || grid[r][c] > mid) {
                return false;
            }
            if (r == n - 1 && c == n - 1) {
                return true;
            }

            visited[r][c] = true;
            return dfs(r + 1, c) || dfs(r - 1, c) || dfs(r, c + 1) || dfs(r, c - 1);
        }

        if (dfs(0, 0)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
}
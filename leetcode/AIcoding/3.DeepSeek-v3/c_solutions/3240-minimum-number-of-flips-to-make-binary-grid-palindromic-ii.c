int minFlips(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int res = 0;

    for (int i = 0; i < m / 2; i++) {
        for (int j = 0; j < n / 2; j++) {
            int cnt1 = grid[i][j] + grid[i][n - 1 - j] + grid[m - 1 - i][j] + grid[m - 1 - i][n - 1 - j];
            res += (cnt1 < 4 - cnt1) ? cnt1 : 4 - cnt1;
        }
    }

    if (m % 2 == 1) {
        for (int j = 0; j < n / 2; j++) {
            if (grid[m / 2][j] != grid[m / 2][n - 1 - j]) {
                res++;
            }
        }
    }

    if (n % 2 == 1) {
        for (int i = 0; i < m / 2; i++) {
            if (grid[i][n / 2] != grid[m - 1 - i][n / 2]) {
                res++;
            }
        }
    }

    return res;
}
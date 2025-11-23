int largest1BorderedSquare(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int hor[m][n], ver[m][n];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                hor[i][j] = (j == 0) ? 1 : hor[i][j-1] + 1;
                ver[i][j] = (i == 0) ? 1 : ver[i-1][j] + 1;
            } else {
                hor[i][j] = 0;
                ver[i][j] = 0;
            }
        }
    }

    int max = 0;
    for (int i = m-1; i >= 0; i--) {
        for (int j = n-1; j >= 0; j--) {
            int small = hor[i][j] < ver[i][j] ? hor[i][j] : ver[i][j];
            while (small > max) {
                if (ver[i][j-small+1] >= small && hor[i-small+1][j] >= small) {
                    max = small;
                }
                small--;
            }
        }
    }

    return max * max;
}
int orderOfLargestPlusSign(int n, int** mines, int minesSize, int* minesColSize) {
    int grid[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            grid[i][j] = 1;
        }
    }

    for (int i = 0; i < minesSize; i++) {
        grid[mines[i][0]][mines[i][1]] = 0;
    }

    int left[n][n], right[n][n], up[n][n], down[n][n];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                left[i][j] = (j == 0) ? 1 : left[i][j-1] + 1;
                up[i][j] = (i == 0) ? 1 : up[i-1][j] + 1;
            } else {
                left[i][j] = 0;
                up[i][j] = 0;
            }
        }
    }

    for (int i = n-1; i >= 0; i--) {
        for (int j = n-1; j >= 0; j--) {
            if (grid[i][j] == 1) {
                right[i][j] = (j == n-1) ? 1 : right[i][j+1] + 1;
                down[i][j] = (i == n-1) ? 1 : down[i+1][j] + 1;
            } else {
                right[i][j] = 0;
                down[i][j] = 0;
            }
        }
    }

    int maxOrder = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int order = fmin(fmin(left[i][j], right[i][j]), fmin(up[i][j], down[i][j]));
            if (order > maxOrder) {
                maxOrder = order;
            }
        }
    }

    return maxOrder;
}
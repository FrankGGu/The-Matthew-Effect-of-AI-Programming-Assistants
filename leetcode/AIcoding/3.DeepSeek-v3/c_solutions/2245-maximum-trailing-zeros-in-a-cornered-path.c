int maxTrailingZeros(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int f2[m][n], f5[m][n];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int x = grid[i][j];
            int cnt2 = 0, cnt5 = 0;
            while (x % 2 == 0) {
                cnt2++;
                x /= 2;
            }
            while (x % 5 == 0) {
                cnt5++;
                x /= 5;
            }
            f2[i][j] = cnt2;
            f5[i][j] = cnt5;
        }
    }

    int pre2_row[m][n+1], pre5_row[m][n+1];
    for (int i = 0; i < m; i++) {
        pre2_row[i][0] = 0;
        pre5_row[i][0] = 0;
        for (int j = 0; j < n; j++) {
            pre2_row[i][j+1] = pre2_row[i][j] + f2[i][j];
            pre5_row[i][j+1] = pre5_row[i][j] + f5[i][j];
        }
    }

    int pre2_col[n][m+1], pre5_col[n][m+1];
    for (int j = 0; j < n; j++) {
        pre2_col[j][0] = 0;
        pre5_col[j][0] = 0;
        for (int i = 0; i < m; i++) {
            pre2_col[j][i+1] = pre2_col[j][i] + f2[i][j];
            pre5_col[j][i+1] = pre5_col[j][i] + f5[i][j];
        }
    }

    int ans = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int left2 = pre2_row[i][j];
            int right2 = pre2_row[i][n] - pre2_row[i][j+1];
            int up2 = pre2_col[j][i];
            int down2 = pre2_col[j][m] - pre2_col[j][i+1];

            int left5 = pre5_row[i][j];
            int right5 = pre5_row[i][n] - pre5_row[i][j+1];
            int up5 = pre5_col[j][i];
            int down5 = pre5_col[j][m] - pre5_col[j][i+1];

            int c2 = f2[i][j], c5 = f5[i][j];

            int v1 = fmin(left2 + up2 + c2, left5 + up5 + c5);
            int v2 = fmin(left2 + down2 + c2, left5 + down5 + c5);
            int v3 = fmin(right2 + up2 + c2, right5 + up5 + c5);
            int v4 = fmin(right2 + down2 + c2, right5 + down5 + c5);

            ans = fmax(ans, fmax(fmax(v1, v2), fmax(v3, v4)));
        }
    }
    return ans;
}
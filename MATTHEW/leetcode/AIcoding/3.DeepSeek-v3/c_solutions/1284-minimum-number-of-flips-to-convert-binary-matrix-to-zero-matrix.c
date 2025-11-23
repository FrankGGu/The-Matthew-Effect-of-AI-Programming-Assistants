int minFlips(int** mat, int matSize, int* matColSize) {
    int m = matSize, n = matColSize[0];
    int total = m * n;
    int minFlips = INT_MAX;

    for (int mask = 0; mask < (1 << total); mask++) {
        int flips = 0;
        int temp[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                temp[i][j] = mat[i][j];
            }
        }

        for (int i = 0; i < total; i++) {
            if (mask & (1 << i)) {
                flips++;
                int r = i / n;
                int c = i % n;
                temp[r][c] ^= 1;
                if (r > 0) temp[r-1][c] ^= 1;
                if (r < m-1) temp[r+1][c] ^= 1;
                if (c > 0) temp[r][c-1] ^= 1;
                if (c < n-1) temp[r][c+1] ^= 1;
            }
        }

        int allZero = 1;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (temp[i][j] != 0) {
                    allZero = 0;
                    break;
                }
            }
            if (!allZero) break;
        }

        if (allZero && flips < minFlips) {
            minFlips = flips;
        }
    }

    return minFlips == INT_MAX ? -1 : minFlips;
}
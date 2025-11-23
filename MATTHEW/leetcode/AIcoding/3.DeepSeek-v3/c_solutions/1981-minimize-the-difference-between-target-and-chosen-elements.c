int dp[71][4901];

int minimizeTheDifference(int** mat, int matSize, int* matColSize, int target) {
    int m = matSize, n = matColSize[0];
    int maxSum = 0;

    for (int i = 0; i < m; i++) {
        int rowMax = 0;
        for (int j = 0; j < n; j++) {
            if (mat[i][j] > rowMax) rowMax = mat[i][j];
        }
        maxSum += rowMax;
    }

    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= maxSum; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j <= maxSum; j++) {
            if (dp[i][j]) {
                for (int k = 0; k < n; k++) {
                    int sum = j + mat[i][k];
                    if (sum <= maxSum) {
                        dp[i+1][sum] = 1;
                    }
                }
            }
        }
    }

    int minDiff = INT_MAX;
    for (int j = 0; j <= maxSum; j++) {
        if (dp[m][j]) {
            int diff = abs(j - target);
            if (diff < minDiff) {
                minDiff = diff;
            }
        }
    }

    return minDiff;
}
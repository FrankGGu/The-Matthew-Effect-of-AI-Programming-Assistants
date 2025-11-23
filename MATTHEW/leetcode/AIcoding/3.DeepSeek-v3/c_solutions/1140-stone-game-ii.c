int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int stoneGameII(int* piles, int pilesSize) {
    int dp[pilesSize][pilesSize + 1];
    int suffixSum[pilesSize];

    suffixSum[pilesSize - 1] = piles[pilesSize - 1];
    for (int i = pilesSize - 2; i >= 0; i--) {
        suffixSum[i] = suffixSum[i + 1] + piles[i];
    }

    for (int i = pilesSize - 1; i >= 0; i--) {
        for (int m = 1; m <= pilesSize; m++) {
            if (i + 2 * m >= pilesSize) {
                dp[i][m] = suffixSum[i];
            } else {
                int minOpponent = INT_MAX;
                for (int x = 1; x <= 2 * m; x++) {
                    minOpponent = min(minOpponent, dp[i + x][max(m, x)]);
                }
                dp[i][m] = suffixSum[i] - minOpponent;
            }
        }
    }

    return dp[0][1];
}
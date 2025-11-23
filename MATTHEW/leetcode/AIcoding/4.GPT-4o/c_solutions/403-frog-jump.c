bool canCross(int* stones, int stonesSize) {
    if (stones[1] != 1) return false;

    int maxJump = stones[stonesSize - 1];
    bool** dp = (bool**)malloc(stonesSize * sizeof(bool*));
    for (int i = 0; i < stonesSize; i++) {
        dp[i] = (bool*)calloc(maxJump + 1, sizeof(bool));
    }

    dp[0][0] = true;

    for (int i = 0; i < stonesSize; i++) {
        for (int j = 0; j <= maxJump; j++) {
            if (dp[i][j]) {
                for (int k = j - 1; k <= j + 1; k++) {
                    if (k > 0) {
                        for (int m = i + 1; m < stonesSize; m++) {
                            if (stones[m] - stones[i] == k) {
                                dp[m][k] = true;
                            }
                            if (stones[m] - stones[i] >= k) break;
                        }
                    }
                }
            }
        }
    }

    for (int j = 0; j <= maxJump; j++) {
        if (dp[stonesSize - 1][j]) {
            for (int i = 0; i < stonesSize; i++) {
                free(dp[i]);
            }
            free(dp);
            return true;
        }
    }

    for (int i = 0; i < stonesSize; i++) {
        free(dp[i]);
    }
    free(dp);
    return false;
}
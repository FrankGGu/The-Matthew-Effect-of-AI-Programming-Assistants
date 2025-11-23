int canCross(int* stones, int stonesSize) {
    if (stonesSize < 2 || stones[1] != 1) return 0;

    int maxJump = stones[stonesSize - 1];
    int** dp = (int**)malloc(sizeof(int*) * stonesSize);
    for (int i = 0; i < stonesSize; i++) {
        dp[i] = (int*)calloc(maxJump + 1, sizeof(int));
    }
    dp[0][0] = 1;

    for (int i = 0; i < stonesSize; i++) {
        for (int j = 0; j <= maxJump; j++) {
            if (dp[i][j]) {
                for (int k = j - 1; k <= j + 1; k++) {
                    if (k > 0) {
                        int nextStone = stones[i] + k;
                        for (int m = i + 1; m < stonesSize; m++) {
                            if (stones[m] == nextStone) {
                                dp[m][k] = 1;
                                if (m == stonesSize - 1) {
                                    for (int x = 0; x < stonesSize; x++) free(dp[x]);
                                    free(dp);
                                    return 1;
                                }
                                break;
                            } else if (stones[m] > nextStone) {
                                break;
                            }
                        }
                    }
                }
            }
        }
    }

    for (int i = 0; i < stonesSize; i++) free(dp[i]);
    free(dp);

    return 0;
}
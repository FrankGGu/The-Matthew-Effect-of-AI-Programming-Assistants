int findMinStep(char *board, char *hand, int handSize) {
    int dp[21][21][21] = {-1}, best = 21;
    int h[26] = {0}, b[26] = {0}, i, j;

    for (i = 0; hand[i]; i++) h[hand[i] - 'A']++;
    for (i = 0; board[i]; i++) b[board[i] - 'A']++;

    for (i = 0; i < 26; i++) {
        if (b[i] > 0) {
            dp[i][b[i]][h[i]] = 0;
        }
    }

    for (i = 0; i < 21; i++) {
        for (j = 0; j < 21; j++) {
            if (j + i > 20) continue;
            if (dp[i][j][0] == -1) continue;
            for (int k = 0; k < 26; k++) {
                if (h[k] > 0) {
                    int newHand = h[k] - 1;
                    int newBalls = j + 1;
                    if (newBalls <= 20) {
                        dp[i][newBalls][newHand] = dp[i][newBalls][newHand] == -1 ? dp[i][j][0] + 1 : fmin(dp[i][newBalls][newHand], dp[i][j][0] + 1);
                    }
                }
            }
            for (int k = 0; k < 26; k++) {
                if (b[k] > 0) {
                    dp[i][j][0] = fmin(dp[i][j][0], dp[i + 1][j - 1][0]);
                }
            }
        }
    }

    for (i = 0; i < 21; i++) {
        for (j = 0; j < 21; j++) {
            if (dp[i][j][0] != -1) {
                best = fmin(best, dp[i][j][0]);
            }
        }
    }

    return best == 21 ? -1 : best;
}
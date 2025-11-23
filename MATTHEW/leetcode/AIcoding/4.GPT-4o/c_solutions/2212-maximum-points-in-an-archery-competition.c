int maxPoints(int numArrows, int* aliceArrows, int aliceArrowsSize){
    int maxPoints = 0;
    int maxScore = 0;
    int dp[10001] = {0};

    for (int i = 0; i < aliceArrowsSize; i++) {
        for (int j = numArrows; j >= aliceArrows[i] + 1; j--) {
            dp[j] = fmax(dp[j], dp[j - aliceArrows[i] - 1] + i + 1);
        }
    }

    for (int j = 0; j <= numArrows; j++) {
        maxPoints = fmax(maxPoints, dp[j]);
    }

    return maxPoints;
}
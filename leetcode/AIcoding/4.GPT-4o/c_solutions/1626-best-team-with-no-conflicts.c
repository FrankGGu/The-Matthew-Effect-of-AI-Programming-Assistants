int bestTeamScore(int* scores, int scoresSize, int* ages, int agesSize) {
    int dp[1001] = {0};
    int players[1001][2];

    for (int i = 0; i < scoresSize; i++) {
        players[i][0] = ages[i];
        players[i][1] = scores[i];
    }

    qsort(players, scoresSize, sizeof(players[0]), [](const void* a, const void* b) {
        return ((const int*)a)[0] == ((const int*)b)[0] ? ((const int*)a)[1] - ((const int*)b)[1] : ((const int*)a)[0] - ((const int*)b)[0];
    });

    int maxScore = 0;
    for (int i = 0; i < scoresSize; i++) {
        dp[i] = players[i][1];
        for (int j = 0; j < i; j++) {
            if (players[j][1] <= players[i][1]) {
                dp[i] = fmax(dp[i], dp[j] + players[i][1]);
            }
        }
        maxScore = fmax(maxScore, dp[i]);
    }

    return maxScore;
}
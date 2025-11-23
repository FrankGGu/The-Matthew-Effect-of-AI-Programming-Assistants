int mostPoints(int** questions, int questionsSize, int* questionsColSize) {
    long long *dp = (long long *)calloc(questionsSize + 1, sizeof(long long));

    for (int i = questionsSize - 1; i >= 0; i--) {
        dp[i] = dp[i + 1];
        dp[i] = fmax(dp[i], questions[i][0] + (i + questions[i][1] + 1 < questionsSize ? dp[i + questions[i][1] + 1] : 0));
    }

    return dp[0];
}
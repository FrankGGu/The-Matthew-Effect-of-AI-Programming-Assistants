long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long mostPoints(int** questions, int questionsSize, int* questionsColSize) {
    long long *dp = (long long *)malloc((questionsSize + 1) * sizeof(long long));
    for (int i = 0; i <= questionsSize; i++) {
        dp[i] = 0;
    }

    for (int i = questionsSize - 1; i >= 0; i--) {
        int points = questions[i][0];
        int brainpower = questions[i][1];
        int next = i + brainpower + 1;
        long long take = points + (next < questionsSize ? dp[next] : 0);
        long long skip = dp[i + 1];
        dp[i] = max(take, skip);
    }

    long long result = dp[0];
    free(dp);
    return result;
}
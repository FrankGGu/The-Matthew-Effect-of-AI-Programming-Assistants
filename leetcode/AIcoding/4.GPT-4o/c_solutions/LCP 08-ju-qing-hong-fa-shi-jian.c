int minimumTime(char **tasks, int tasksSize) {
    int dp[1001] = {0};
    for (int i = 0; i < tasksSize; i++) {
        int time = tasks[i][0] - '0';
        int cooldown = tasks[i][1] - '0';
        for (int j = 1000; j >= time; j--) {
            dp[j] = fmax(dp[j], dp[j - time] + cooldown);
        }
    }
    int result = 0;
    for (int i = 0; i <= 1000; i++) {
        if (dp[i] <= i) {
            result = i;
            break;
        }
    }
    return result;
}
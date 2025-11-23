int maximizeWin(int* prizePositions, int prizePositionsSize, int k) {
    int n = prizePositionsSize;
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) dp[i] = 0;

    int left = 0;
    int maxWin = 0;

    for (int right = 0; right < n; right++) {
        while (prizePositions[right] - prizePositions[left] > k) {
            left++;
        }
        int currentWin = right - left + 1;
        dp[right + 1] = (dp[right] > currentWin) ? dp[right] : currentWin;
        int totalWin = currentWin + dp[left];
        if (totalWin > maxWin) {
            maxWin = totalWin;
        }
    }

    free(dp);
    return maxWin;
}
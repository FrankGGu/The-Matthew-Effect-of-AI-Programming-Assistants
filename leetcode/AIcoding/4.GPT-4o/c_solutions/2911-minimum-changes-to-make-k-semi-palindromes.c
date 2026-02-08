#define MAXN 1000

int minChanges(char* s, int k) {
    int n = strlen(s);
    int dp[MAXN + 1][MAXN + 1] = {0};
    int cost[MAXN][MAXN] = {0};

    for (int i = 0; i < n; i++) {
        for (int j = i, l = 0; j < n; j++, l++) {
            cost[i][j] = l / 2;
            if (s[i + l] != s[j]) cost[i][j]++;
        }
    }

    for (int i = 0; i <= n; i++) {
        for (int j = 1; j <= k; j++) {
            dp[i][j] = MAXN;
            for (int l = 0; l <= i; l++) {
                dp[i][j] = fmin(dp[i][j], dp[i - l][j - 1] + cost[i - l][i - 1]);
            }
        }
    }
    return dp[n][k];
}
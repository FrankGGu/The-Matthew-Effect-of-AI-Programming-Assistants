int findMaxForm(char ** strs, int strsSize, int m, int n) {
    int dp[m+1][n+1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < strsSize; i++) {
        int count0 = 0, count1 = 0;
        for (char *s = strs[i]; *s; s++) {
            if (*s == '0') count0++;
            else count1++;
        }
        for (int j = m; j >= count0; j--) {
            for (int k = n; k >= count1; k--) {
                dp[j][k] = fmax(dp[j][k], dp[j - count0][k - count1] + 1);
            }
        }
    }
    return dp[m][n];
}
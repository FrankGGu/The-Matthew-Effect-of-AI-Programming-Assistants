int deleteString(char * s){
    int n = strlen(s);
    if (n == 1) return 1;

    int** lcs = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        lcs[i] = (int*)malloc((n + 1) * sizeof(int));
        memset(lcs[i], 0, (n + 1) * sizeof(int));
    }

    int* dp = (int*)malloc(n * sizeof(int));
    for (int i = n - 1; i >= 0; i--) {
        dp[i] = 1;
        for (int j = i + 1; j < n; j++) {
            if (s[i] == s[j]) {
                lcs[i][j] = lcs[i + 1][j + 1] + 1;
            } else {
                lcs[i][j] = 0;
            }
            if (lcs[i][j] >= j - i) {
                dp[i] = fmax(dp[i], dp[j] + 1);
            }
        }
    }

    for (int i = 0; i <= n; i++) {
        free(lcs[i]);
    }
    free(lcs);
    int res = dp[0];
    free(dp);
    return res;
}
bool dp[41][41][2000];

bool possiblyEquals(char* s1, char* s2) {
    int n1 = strlen(s1), n2 = strlen(s2);
    memset(dp, 0, sizeof(dp));
    dp[0][0][1000] = true;

    for (int i = 0; i <= n1; i++) {
        for (int j = 0; j <= n2; j++) {
            for (int diff = 0; diff < 2000; diff++) {
                if (!dp[i][j][diff]) continue;

                if (i < n1 && j < n2 && s1[i] == s2[j] && isalpha(s1[i])) {
                    dp[i+1][j+1][diff] = true;
                }

                if (i < n1 && isdigit(s1[i])) {
                    int num = 0;
                    for (int k = i; k < n1 && k < i+3 && isdigit(s1[k]); k++) {
                        num = num * 10 + (s1[k] - '0');
                        if (diff - num >= 0) {
                            dp[k+1][j][diff - num] = true;
                        }
                    }
                }

                if (j < n2 && isdigit(s2[j])) {
                    int num = 0;
                    for (int k = j; k < n2 && k < j+3 && isdigit(s2[k]); k++) {
                        num = num * 10 + (s2[k] - '0');
                        if (diff + num < 2000) {
                            dp[i][k+1][diff + num] = true;
                        }
                    }
                }

                if (i < n1 && isalpha(s1[i]) && diff < 1999) {
                    dp[i+1][j][diff+1] = true;
                }

                if (j < n2 && isalpha(s2[j]) && diff > 0) {
                    dp[i][j+1][diff-1] = true;
                }
            }
        }
    }

    return dp[n1][n2][1000];
}
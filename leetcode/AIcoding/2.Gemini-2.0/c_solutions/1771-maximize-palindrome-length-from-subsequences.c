#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maximizePalindromeLength(char * word1, char * word2) {
    int n1 = strlen(word1);
    int n2 = strlen(word2);
    char *s = (char *)malloc(sizeof(char) * (n1 + n2 + 1));
    strcpy(s, word1);
    strcat(s, word2);
    int n = n1 + n2;

    int dp[n][n];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (s[i] == s[j]) {
                dp[i][j] = dp[i + 1][j - 1] + 2;
            } else {
                dp[i][j] = max(dp[i + 1][j], dp[i][j - 1]);
            }
        }
    }

    int ans = 0;
    for (int i = 0; i < n1; i++) {
        for (int j = n1; j < n; j++) {
            if (s[i] == s[j]) {
                int temp = 2;
                if (i + 1 <= j - 1) {
                    temp += dp[i + 1][j - 1];
                }
                ans = max(ans, temp);
            }
        }
    }

    free(s);
    return ans;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCut(char * s){
    int n = strlen(s);
    if (n <= 1) return 0;

    int dp[n];
    for (int i = 0; i < n; i++) {
        dp[i] = i;
    }

    int isPalindrome[n][n];
    memset(isPalindrome, 0, sizeof(isPalindrome));

    for (int i = 0; i < n; i++) {
        isPalindrome[i][i] = 1;
    }

    for (int i = 0; i < n - 1; i++) {
        if (s[i] == s[i + 1]) {
            isPalindrome[i][i + 1] = 1;
        }
    }

    for (int len = 3; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (s[i] == s[j] && isPalindrome[i + 1][j - 1]) {
                isPalindrome[i][j] = 1;
            }
        }
    }

    for (int i = 1; i < n; i++) {
        if (isPalindrome[0][i]) {
            dp[i] = 0;
        } else {
            for (int j = 0; j < i; j++) {
                if (isPalindrome[j + 1][i]) {
                    dp[i] = (dp[i] < dp[j] + 1) ? dp[i] : (dp[j] + 1);
                }
            }
        }
    }

    return dp[n - 1];
}
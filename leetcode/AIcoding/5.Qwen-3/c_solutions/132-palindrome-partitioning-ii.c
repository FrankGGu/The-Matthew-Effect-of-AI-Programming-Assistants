#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int** generatePalindromeTable(char* s, int n) {
    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (int length = 2; length <= n; length++) {
        for (int i = 0; i <= n - length; i++) {
            int j = i + length - 1;
            if (s[i] == s[j]) {
                if (length == 2) {
                    dp[i][j] = 1;
                } else {
                    dp[i][j] = dp[i + 1][j - 1];
                }
            } else {
                dp[i][j] = 0;
            }
        }
    }

    return dp;
}

int minCut(char* s) {
    int n = strlen(s);
    if (n <= 1) return 0;

    int** isPalindrome = generatePalindromeTable(s, n);

    int* dp = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dp[i] = i; // Max possible cuts
    }

    for (int i = 1; i < n; i++) {
        if (isPalindrome[0][i]) {
            dp[i] = 0;
            continue;
        }

        for (int j = 0; j < i; j++) {
            if (isPalindrome[j + 1][i]) {
                dp[i] = min(dp[i], dp[j] + 1);
            }
        }
    }

    int result = dp[n - 1];
    free(dp);
    for (int i = 0; i < n; i++) {
        free(isPalindrome[i]);
    }
    free(isPalindrome);

    return result;
}
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <limits.h>

static int min(int a, int b) {
    return (a < b) ? a : b;
}

int minCut(char * s){
    int n = strlen(s);

    if (n == 0) {
        return 0;
    }

    bool **isPalindrome = (bool **)malloc(n * sizeof(bool *));
    for (int i = 0; i < n; i++) {
        isPalindrome[i] = (bool *)malloc(n * sizeof(bool));
        for (int j = 0; j < n; j++) {
            isPalindrome[i][j] = false;
        }
    }

    for (int len = 1; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (len == 1) {
                isPalindrome[i][j] = true;
            } else if (len == 2) {
                isPalindrome[i][j] = (s[i] == s[j]);
            } else {
                isPalindrome[i][j] = (s[i] == s[j] && isPalindrome[i+1][j-1]);
            }
        }
    }

    int *dp = (int *)malloc((n + 1) * sizeof(int));
    dp[n] = 0;

    for (int i = n - 1; i >= 0; i--) {
        dp[i] = INT_MAX; 
        for (int j = i; j < n; j++) {
            if (isPalindrome[i][j]) {
                if (j == n - 1) {
                    dp[i] = 0;
                } else {
                    dp[i] = min(dp[i], 1 + dp[j+1]);
                }
            }
        }
    }

    int result = dp[0];

    for (int i = 0; i < n; i++) {
        free(isPalindrome[i]);
    }
    free(isPalindrome);
    free(dp);

    return result;
}
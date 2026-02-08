#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int maxPalindromes(char* s, int k) {
    int n = strlen(s);

    bool** is_palindrome = (bool**)malloc(n * sizeof(bool*));
    for (int i = 0; i < n; i++) {
        is_palindrome[i] = (bool*)malloc(n * sizeof(bool));
    }

    for (int i = 0; i < n; i++) {
        is_palindrome[i][i] = true;
    }

    for (int i = 0; i < n - 1; i++) {
        if (s[i] == s[i+1]) {
            is_palindrome[i][i+1] = true;
        }
    }

    for (int len = 3; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            if (s[i] == s[j] && is_palindrome[i+1][j-1]) {
                is_palindrome[i][j] = true;
            }
        }
    }

    int* dp = (int*)malloc((n + 1) * sizeof(int));
    dp[0] = 0;

    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i-1];

        for (int j = i - 1; j >= 0; j--) {
            int current_len = i - j;
            if (current_len >= k && is_palindrome[j][i-1]) {
                dp[i] = max(dp[i], dp[j] + 1);
            }
        }
    }

    int result = dp[n];

    for (int i = 0; i < n; i++) {
        free(is_palindrome[i]);
    }
    free(is_palindrome);
    free(dp);

    return result;
}
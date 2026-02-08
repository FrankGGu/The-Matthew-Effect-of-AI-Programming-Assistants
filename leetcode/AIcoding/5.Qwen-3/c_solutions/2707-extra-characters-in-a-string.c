#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int solve(int n, char* s, char** dictionary, int dictSize, int* dp) {
    if (n == 0) return 0;
    if (dp[n] != -1) return dp[n];

    int res = solve(n - 1, s, dictionary, dictSize, dp) + 1;

    for (int i = 0; i < dictSize; i++) {
        int len = strlen(dictionary[i]);
        if (len <= n && strncmp(s + n - len, dictionary[i], len) == 0) {
            res = min(res, solve(n - len, s, dictionary, dictSize, dp));
        }
    }

    dp[n] = res;
    return res;
}

int extraCharacters(char* s, char** dictionary, int dictSize) {
    int n = strlen(s);
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) {
        dp[i] = -1;
    }
    int result = solve(n, s, dictionary, dictSize, dp);
    free(dp);
    return result;
}
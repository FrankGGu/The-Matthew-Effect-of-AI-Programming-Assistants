#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int solve(int idx, int k, int n, int len, int *dp, char *s, char *special) {
    if (k == 0) return 0;
    if (idx >= n) return -1e9;

    int key = idx * 101 + k;
    if (dp[key] != -1) return dp[key];

    int ans = solve(idx + 1, k, n, len, dp, s, special);

    int found = 1;
    for (int i = 0; i < len; i++) {
        if (idx + i >= n || s[idx + i] != special[i]) {
            found = 0;
            break;
        }
    }

    if (found) {
        ans = max(ans, 1 + solve(idx + len, k - 1, n, len, dp, s, special));
    }

    return dp[key] = ans;
}

int maxKSpecialSubstrings(char *s, char *special, int k) {
    int n = strlen(s);
    int len = strlen(special);
    int dp[10101];
    for (int i = 0; i < 10101; i++) {
        dp[i] = -1;
    }
    int ans = solve(0, k, n, len, dp, s, special);
    return (ans < 0) ? 0 : ans;
}
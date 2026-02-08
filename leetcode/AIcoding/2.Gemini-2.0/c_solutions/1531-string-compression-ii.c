#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getLength(int count) {
    if (count == 1) return 1;
    if (count < 10) return 2;
    if (count < 100) return 3;
    return 4;
}

int dp[101][101];

int solve(char* s, int i, int k, int n) {
    if (k < 0) return INT_MAX;
    if (i == n) return 0;

    if (dp[i][k] != -1) return dp[i][k];

    int ans = INT_MAX;

    ans = solve(s, i + 1, k - 1, n);

    int count = 0;
    for (int j = i; j < n; j++) {
        if (s[i] == s[j]) {
            count++;
            ans = fmin(ans, getLength(count) + solve(s, j + 1, k, n));
        } else {
            if (k > 0) {
                ans = fmin(ans, solve(s, j, k - 1, n));
            }
            break;
        }

    }

    return dp[i][k] = ans;
}

int getLengthOfOptimalCompression(char* s, int k) {
    int n = strlen(s);
    memset(dp, -1, sizeof(dp));
    return solve(s, 0, k, n);
}
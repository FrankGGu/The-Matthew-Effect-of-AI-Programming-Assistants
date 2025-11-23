#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int A;
int dp[11][2][1 << 10];
int digit[11];
int len;

int dfs(int pos, bool limit, int mask) {
    if (pos == len) {
        return 1;
    }
    if (dp[pos][limit][mask] != -1) {
        return dp[pos][limit][mask];
    }

    int up = limit ? digit[pos] : 9;
    int ans = 0;
    for (int i = 0; i <= up; i++) {
        if ((mask & (1 << i)) && (mask != 0)) continue;

        ans += dfs(pos + 1, limit && (i == digit[pos]), (mask == 0 && i == 0) ? 0 : (mask | (1 << i)));
    }

    return dp[pos][limit][mask] = ans;
}

int solve(int x) {
    len = 0;
    while (x) {
        digit[len++] = x % 10;
        x /= 10;
    }
    for (int i = 0; i < len / 2; i++) {
        int temp = digit[i];
        digit[i] = digit[len - 1 - i];
        digit[len - 1 - i] = temp;
    }

    for (int i = 0; i < 11; i++) {
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < (1 << 10); k++) {
                dp[i][j][k] = -1;
            }
        }
    }
    return dfs(0, true, 0);
}

int numDupDigitsAtMostN(int n){
    A = n;
    return A - solve(A);
}
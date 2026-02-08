#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long dp[11][1 << 10][2][2];
int digits[11];
int k;

long long dfs(int pos, int mask, bool limit, bool isNum) {
    if (pos == -1) {
        return isNum && (__builtin_popcount(mask) >= k);
    }
    if (dp[pos][mask][limit][isNum] != -1) {
        return dp[pos][mask][limit][isNum];
    }

    int up = limit ? digits[pos] : 9;
    long long ans = 0;
    for (int i = 0; i <= up; i++) {
        ans += dfs(pos - 1, isNum || (i > 0) ? (mask | (1 << i)) : mask, limit && (i == digits[pos]), isNum || (i > 0));
    }

    return dp[pos][mask][limit][isNum] = ans;
}

long long solve(long long n) {
    int len = 0;
    while (n) {
        digits[len++] = n % 10;
        n /= 10;
    }
    memset(dp, -1, sizeof(dp));
    return dfs(len - 1, 0, true, false);
}

int countBeautifulIntegers(int low, int high, int k_) {
    k = k_;
    return solve(high) - solve(low - 1);
}
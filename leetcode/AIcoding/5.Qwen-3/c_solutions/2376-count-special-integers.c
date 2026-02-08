#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countSpecialNumbers(int n) {
    char s[12];
    sprintf(s, "%d", n);
    int len = strlen(s);
    long long dp[12][10][2][2];
    memset(dp, -1, sizeof(dp));

    long long dfs(int pos, int pre, int tight, int leading) {
        if (pos == len) {
            return !leading;
        }
        if (dp[pos][pre][tight][leading] != -1) {
            return dp[pos][pre][tight][leading];
        }

        long long res = 0;
        int up = tight ? s[pos] - '0' : 9;

        for (int i = 0; i <= up; ++i) {
            int new_tight = tight && (i == up);
            int new_leading = leading && (i == 0);
            int new_pre = i;

            if (!new_leading) {
                if (leading && i == 0) {
                    res += dfs(pos + 1, pre, new_tight, new_leading);
                } else {
                    if (pre != i) {
                        res += dfs(pos + 1, i, new_tight, new_leading);
                    }
                }
            } else {
                res += dfs(pos + 1, pre, new_tight, new_leading);
            }
        }

        dp[pos][pre][tight][leading] = res;
        return res;
    }

    return dfs(0, -1, 1, 1);
}

long long countSpecialNumbers(int n) {
    char s[12];
    sprintf(s, "%d", n);
    int len = strlen(s);
    long long dp[12][10][2][2];
    memset(dp, -1, sizeof(dp));

    long long dfs(int pos, int pre, int tight, int leading) {
        if (pos == len) {
            return !leading;
        }
        if (dp[pos][pre][tight][leading] != -1) {
            return dp[pos][pre][tight][leading];
        }

        long long res = 0;
        int up = tight ? s[pos] - '0' : 9;

        for (int i = 0; i <= up; ++i) {
            int new_tight = tight && (i == up);
            int new_leading = leading && (i == 0);
            int new_pre = i;

            if (!new_leading) {
                if (leading && i == 0) {
                    res += dfs(pos + 1, pre, new_tight, new_leading);
                } else {
                    if (pre != i) {
                        res += dfs(pos + 1, i, new_tight, new_leading);
                    }
                }
            } else {
                res += dfs(pos + 1, pre, new_tight, new_leading);
            }
        }

        dp[pos][pre][tight][leading] = res;
        return res;
    }

    return dfs(0, -1, 1, 1);
}
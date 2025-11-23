#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSpecialIntegers(int n) {
    char s[11];
    sprintf(s, "%d", n);
    int len = strlen(s);
    int dp[len][1 << 10];
    memset(dp, -1, sizeof(dp));

    int dfs(int pos, int mask, bool limit, bool is_num) {
        if (pos == len) {
            return is_num;
        }
        if (!limit && is_num && dp[pos][mask] != -1) {
            return dp[pos][mask];
        }

        int up = limit ? (s[pos] - '0') : 9;
        int ans = 0;
        if (!is_num) {
            ans += dfs(pos + 1, mask, false, false);
        }
        int start = is_num ? 0 : 1;
        for (int i = start; i <= up; i++) {
            if (!(mask & (1 << i))) {
                ans += dfs(pos + 1, mask | (1 << i), limit && (i == up), true);
            }
        }

        if (!limit && is_num) {
            dp[pos][mask] = ans;
        }
        return ans;
    }

    return dfs(0, 0, true, false);
}
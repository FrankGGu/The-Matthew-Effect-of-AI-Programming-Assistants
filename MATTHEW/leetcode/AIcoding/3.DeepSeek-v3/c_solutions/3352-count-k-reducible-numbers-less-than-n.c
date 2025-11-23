#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countKReducibleNumbers(int n, int k) {
    if (n == 1) return 0;

    char str[11];
    sprintf(str, "%d", n);
    int len = strlen(str);

    int dp[11][2][2][10];
    memset(dp, -1, sizeof(dp));

    int dfs(int pos, int isLimit, int isNum, int lastDigit) {
        if (pos == len) return isNum ? 1 : 0;
        if (dp[pos][isLimit][isNum][lastDigit] != -1) return dp[pos][isLimit][isNum][lastDigit];

        int res = 0;
        if (!isNum) {
            res += dfs(pos + 1, 0, 0, 0);
        }

        int low = isNum ? 0 : 1;
        int high = isLimit ? str[pos] - '0' : 9;

        for (int d = low; d <= high; d++) {
            if (!isNum || abs(d - lastDigit) <= k) {
                res += dfs(pos + 1, isLimit && (d == high), 1, d);
            }
        }

        return dp[pos][isLimit][isNum][lastDigit] = res;
    }

    return dfs(0, 1, 0, 0);
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int count_k_reducible(long long n, int k) {
    if (n <= 0 || k <= 1) {
        return 0;
    }

    char s[20];
    sprintf(s, "%lld", n);
    int len = strlen(s);

    int dp[20][2][2];
    memset(dp, 0, sizeof(dp));

    dp[0][1][0] = 1;

    for (int i = 0; i < len; i++) {
        for (int tight = 0; tight < 2; tight++) {
            for (int nonzero = 0; nonzero < 2; nonzero++) {
                int ub = tight ? (s[i] - '0') : 9;
                for (int d = 0; d <= ub; d++) {
                    int new_tight = tight && (d == ub);
                    int new_nonzero = nonzero || (d > 0);
                    dp[i + 1][new_tight][new_nonzero] += dp[i][tight][nonzero];
                }
            }
        }
    }

    int result = 0;
    for (int tight = 0; tight < 2; tight++) {
        result += dp[len][tight][1];
    }

    long long num = n;
    while (num > 0) {
        if (num % k != 0) {
            return result - 1;
        }
        num /= k;
    }

    return result;
}
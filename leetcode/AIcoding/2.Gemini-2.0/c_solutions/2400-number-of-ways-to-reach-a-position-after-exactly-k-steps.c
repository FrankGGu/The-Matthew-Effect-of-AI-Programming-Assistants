#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfWays(int startPos, int endPos, int k) {
    long long dp[3001][1001] = {0};
    int mod = 1000000007;
    int diff = abs(startPos - endPos);

    if ((k - diff) % 2 != 0) {
        return 0;
    }

    dp[1500 + diff][0] = 1;

    for (int steps = 1; steps <= k; steps++) {
        for (int pos = 0; pos <= 3000; pos++) {
            if (dp[pos][steps - 1] > 0) {
                if (pos > 0) {
                    dp[pos - 1][steps] = (dp[pos - 1][steps] + dp[pos][steps - 1]) % mod;
                }
                if (pos < 3000) {
                    dp[pos + 1][steps] = (dp[pos + 1][steps] + dp[pos][steps - 1]) % mod;
                }
            }
        }
    }

    return (int)dp[1500][k];
}
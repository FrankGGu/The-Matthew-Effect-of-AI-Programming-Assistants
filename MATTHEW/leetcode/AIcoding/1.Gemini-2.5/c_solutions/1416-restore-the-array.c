#include <string.h>
#include <stdlib.h>

int numberOfArrays(char* s, int k) {
    int n = strlen(s);
    long long MOD = 1000000007;

    int* dp = (int*)calloc(n + 1, sizeof(int));

    dp[n] = 1;

    for (int i = n - 1; i >= 0; --i) {
        if (s[i] == '0') {
            dp[i] = 0;
            continue;
        }

        long long currentNum = 0;
        for (int j = i; j < n; ++j) {
            currentNum = currentNum * 10 + (s[j] - '0');

            if (currentNum > k) {
                break;
            }

            dp[i] = (dp[i] + dp[j + 1]) % MOD;
        }
    }

    int result = dp[0];
    free(dp);
    return result;
}
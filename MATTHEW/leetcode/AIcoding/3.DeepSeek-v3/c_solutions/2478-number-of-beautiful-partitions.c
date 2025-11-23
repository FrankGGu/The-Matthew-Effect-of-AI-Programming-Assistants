#include <string.h>
#include <stdbool.h>

bool isPrime(char c) {
    return c == '2' || c == '3' || c == '5' || c == '7';
}

int beautifulPartitions(char* s, int k, int minLength) {
    int n = strlen(s);
    int mod = 1e9 + 7;

    if (!isPrime(s[0]) || isPrime(s[n - 1])) {
        return 0;
    }

    int dp[k + 1][n + 1];
    memset(dp, 0, sizeof(dp));
    dp[0][0] = 1;

    for (int i = 1; i <= k; i++) {
        int sum = 0;
        for (int j = i * minLength; j <= n; j++) {
            if (j - minLength >= 0 && !isPrime(s[j - minLength]) && (j - minLength == 0 || isPrime(s[j - minLength - 1]))) {
                sum = (sum + dp[i - 1][j - minLength]) % mod;
            }
            if (!isPrime(s[j - 1])) {
                dp[i][j] = sum;
            }
        }
    }

    return dp[k][n];
}
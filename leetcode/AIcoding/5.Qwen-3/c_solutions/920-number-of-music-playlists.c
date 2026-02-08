#include <stdio.h>
#include <stdlib.h>

long long pow_mod(int base, int exp, int mod) {
    long long result = 1;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    return result;
}

long long comb(int n, int k, int mod) {
    long long numerator = 1;
    long long denominator = 1;
    for (int i = 0; i < k; i++) {
        numerator = (numerator * (n - i)) % mod;
        denominator = (denominator * (i + 1)) % mod;
    }
    return (numerator * pow_mod(denominator, mod - 2, mod)) % mod;
}

int numMusicPlaylists(int n, int k, int target) {
    int mod = 1000000007;
    long long dp[2][target + 1];
    for (int i = 0; i <= target; i++) {
        dp[0][i] = 0;
        dp[1][i] = 0;
    }
    dp[0][0] = 1;
    for (int i = 1; i <= target; i++) {
        for (int j = 1; j <= i && j <= n; j++) {
            dp[j % 2][i] = (dp[(j - 1) % 2][i - 1] * (n - j + 1)) % mod;
            if (j >= k) {
                dp[j % 2][i] = (dp[j % 2][i] + dp[j % 2][i - 1] * (j - k + 1)) % mod;
            }
        }
    }
    return dp[target % 2][target];
}
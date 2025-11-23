#define MOD 1000000007

int countWays(int *prevRoom, int prevSize) {
    long long dp[prevSize + 1];
    long long factorial[prevSize + 1];
    long long invFactorial[prevSize + 1];

    dp[0] = 1;
    for (int i = 1; i <= prevSize; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < prevSize; i++) {
        dp[prevRoom[i]]++;
    }

    factorial[0] = 1;
    for (int i = 1; i <= prevSize; i++) {
        factorial[i] = factorial[i - 1] * i % MOD;
    }

    invFactorial[prevSize] = 1;
    for (int i = 1; i <= prevSize; i++) {
        invFactorial[i] = (MOD - MOD / i) * invFactorial[MOD % i] % MOD;
    }

    long long result = 1;
    long long total = 0;
    for (int i = 0; i < prevSize; i++) {
        total += dp[i];
        result = result * factorial[dp[i]] % MOD;
    }

    result = result * factorial[total] % MOD;

    for (int i = 0; i < prevSize; i++) {
        result = result * invFactorial[dp[i]] % MOD;
    }

    return (int)result;
}
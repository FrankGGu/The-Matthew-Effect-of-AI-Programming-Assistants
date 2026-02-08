int numberOfUniqueGoodSubsequences(char* binary) {
    int mod = 1000000007;
    long long dp0 = 0, dp1 = 0;
    int has0 = 0;

    for (int i = 0; binary[i] != '\0'; i++) {
        if (binary[i] == '0') {
            has0 = 1;
            dp0 = (dp0 + dp1) % mod;
        } else {
            dp1 = (dp0 + dp1 + 1) % mod;
        }
    }

    return (dp0 + dp1 + has0) % mod;
}
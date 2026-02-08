int concatenatedBinary(int n) {
    long long result = 0;
    int MOD = 1e9 + 7;
    int len = 0;

    for (int i = 1; i <= n; i++) {
        if ((i & (i - 1)) == 0) {
            len++;
        }
        result = ((result << len) | i) % MOD;
    }

    return (int)result;
}
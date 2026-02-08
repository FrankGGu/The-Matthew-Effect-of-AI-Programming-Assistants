int concatenatedBinary(int n) {
    long long result = 0;
    long long mod = 1000000007;
    int length = 0;

    for (int i = 1; i <= n; i++) {
        if ((i & (i - 1)) == 0) length++;
        result = ((result << length) | i) % mod;
    }

    return (int)result;
}
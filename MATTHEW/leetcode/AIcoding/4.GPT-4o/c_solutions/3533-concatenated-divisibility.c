int concatenatedBinary(int n) {
    long long result = 0;
    int mod = 1000000007;
    for (int i = 1; i <= n; i++) {
        int length = (int)log2(i) + 1;
        result = ((result << length) % mod + i) % mod;
    }
    return (int)result;
}
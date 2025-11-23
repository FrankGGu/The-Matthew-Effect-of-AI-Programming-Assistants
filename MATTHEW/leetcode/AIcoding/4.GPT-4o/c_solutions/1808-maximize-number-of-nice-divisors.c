int maxNiceDivisors(int n) {
    if (n <= 3) return n;
    long long mod = 1e9 + 7;
    long long result = 1;

    while (n > 4) {
        result = (result * 3) % mod;
        n -= 3;
    }

    return (result * n) % mod;
}
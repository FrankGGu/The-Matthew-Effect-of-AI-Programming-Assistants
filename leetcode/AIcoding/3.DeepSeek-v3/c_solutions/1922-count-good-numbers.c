long long modPow(long long base, long long exp, long long mod) {
    long long result = 1;
    base %= mod;
    while (exp > 0) {
        if (exp & 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp >>= 1;
    }
    return result;
}

int countGoodNumbers(long long n) {
    long long mod = 1000000007;
    long long evenPositions = (n + 1) / 2;
    long long oddPositions = n / 2;

    long long evenWays = modPow(5, evenPositions, mod);
    long long oddWays = modPow(4, oddPositions, mod);

    return (evenWays * oddWays) % mod;
}
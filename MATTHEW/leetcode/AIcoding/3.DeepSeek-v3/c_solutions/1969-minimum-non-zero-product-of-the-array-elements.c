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

int minNonZeroProduct(int p) {
    long long mod = 1000000007;
    long long maxNum = (1LL << p) - 1;
    long long pairs = maxNum / 2;
    long long product = modPow(maxNum - 1, pairs, mod);
    product = (product * (maxNum % mod)) % mod;
    return (int)product;
}
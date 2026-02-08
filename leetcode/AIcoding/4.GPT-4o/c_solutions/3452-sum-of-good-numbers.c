#define MOD 1000000007

long long modPow(long long base, long long exp, long long mod) {
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

int countGoodNumbers(long long n) {
    if (n % 2 == 0) {
        return modPow(5, n / 2, MOD) * modPow(4, n / 2, MOD) % MOD;
    } else {
        return modPow(5, n / 2 + 1, MOD) * modPow(4, n / 2, MOD) % MOD;
    }
}
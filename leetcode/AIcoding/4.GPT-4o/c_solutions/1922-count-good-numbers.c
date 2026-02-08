#define MOD 1000000007

long long power(long long x, long long y) {
    long long res = 1;
    x = x % MOD;
    while (y > 0) {
        if (y & 1) res = (res * x) % MOD;
        y = y >> 1;
        x = (x * x) % MOD;
    }
    return res;
}

int countGoodNumbers(long long n) {
    if (n % 2 == 0) {
        return (power(5, n / 2) * power(4, n / 2)) % MOD;
    } else {
        return (power(5, n / 2) * power(4, n / 2 + 1)) % MOD;
    }
}
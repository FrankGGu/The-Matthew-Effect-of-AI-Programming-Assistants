#define MOD 1000000007

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

int numberOfGoodStrings(int n) {
    if (n < 3) {
        return 0;
    }

    long long term1 = power(3, n);
    long long term2 = (3 * power(2, n)) % MOD;
    long long term3 = 3;

    long long result = (term1 - term2 + term3) % MOD;

    if (result < 0) {
        result += MOD;
    }

    return (int)result;
}
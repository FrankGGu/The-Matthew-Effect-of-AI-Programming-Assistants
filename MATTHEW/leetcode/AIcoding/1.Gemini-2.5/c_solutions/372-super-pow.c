#define MOD 1337

int pow_mod(int base, int exp) {
    int res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) {
            res = (long long)res * base % MOD;
        }
        base = (long long)base * base % MOD;
        exp /= 2;
    }
    return res;
}

int superPow(int a, int* b, int bSize) {
    if (bSize == 0) {
        return 1;
    }

    a %= MOD;

    int result = 1;
    for (int i = 0; i < bSize; ++i) {
        result = (pow_mod(result, 10) * pow_mod(a, b[i])) % MOD;
    }

    return result;
}
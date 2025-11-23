int superPow(int a, int* b, int bSize) {
    int mod = 1337;
    a %= mod;
    if (a == 0) return 0;

    int result = 1;
    for (int i = 0; i < bSize; i++) {
        result = powMod(result, 10, mod);
        result = (result * powMod(a, b[i], mod)) % mod;
    }
    return result;
}

int powMod(int base, int exponent, int mod) {
    int result = 1;
    base %= mod;
    while (exponent > 0) {
        if (exponent & 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exponent >>= 1;
    }
    return result;
}
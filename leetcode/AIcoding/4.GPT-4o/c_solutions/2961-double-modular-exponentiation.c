int mod_exp(int base, int exp, int mod) {
    long long result = 1;
    long long b = base % mod;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * b) % mod;
        }
        b = (b * b) % mod;
        exp /= 2;
    }
    return result;
}

int doubleModularExponentiation(int a, int b, int c, int d, int mod) {
    int first_exp = mod_exp(a, b, mod);
    int second_exp = mod_exp(c, d, mod);
    return (first_exp + second_exp) % mod;
}
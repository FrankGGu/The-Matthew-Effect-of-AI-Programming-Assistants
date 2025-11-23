int mod = 1337;

int quickPow(int a, int b) {
    long res = 1;
    long x = a % mod;
    while (b > 0) {
        if (b % 2 == 1) {
            res = (res * x) % mod;
        }
        x = (x * x) % mod;
        b /= 2;
    }
    return (int)res;
}

int superPow(int a, int* b, int bSize) {
    if (bSize == 0) return 1;
    return (quickPow(a, b[bSize - 1]) * superPow(a, b, bSize - 1)) % mod;
}
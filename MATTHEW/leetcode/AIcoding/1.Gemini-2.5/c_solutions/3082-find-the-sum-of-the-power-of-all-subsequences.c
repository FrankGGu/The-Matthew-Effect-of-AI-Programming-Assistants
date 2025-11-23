long long power(long long base, long long exp) {
    long long res = 1;
    long long MOD = 1e9 + 7;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) {
            res = (res * base) % MOD;
        }
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long sumOfPower(int* nums, int numsSize, int k) {
    long long MOD = 1e9 + 7;
    long long base = (1LL + k) % MOD;
    long long exponent = numsSize;

    return power(base, exponent);
}
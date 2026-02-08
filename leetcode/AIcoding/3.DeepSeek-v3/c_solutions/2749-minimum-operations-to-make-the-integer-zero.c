long long makeIntegerZero(long long num1, long long num2) {
    for (int k = 1; k <= 60; k++) {
        long long x = num1 - k * num2;
        if (x < 0) continue;
        int bits = __builtin_popcountll(x);
        if (bits <= k && k <= x) {
            return k;
        }
    }
    return -1;
}
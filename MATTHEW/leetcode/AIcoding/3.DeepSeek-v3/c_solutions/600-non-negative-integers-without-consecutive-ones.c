int findIntegers(int n) {
    int fib[32];
    fib[0] = 1;
    fib[1] = 2;
    for (int i = 2; i < 32; i++) {
        fib[i] = fib[i-1] + fib[i-2];
    }

    int ans = 0, prev_bit = 0;
    for (int i = 30; i >= 0; i--) {
        if (n & (1 << i)) {
            ans += fib[i];
            if (prev_bit) {
                return ans;
            }
            prev_bit = 1;
        } else {
            prev_bit = 0;
        }
    }
    return ans + 1;
}
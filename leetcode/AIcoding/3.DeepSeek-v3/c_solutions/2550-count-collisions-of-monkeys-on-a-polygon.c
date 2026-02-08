int monkeyMove(int n) {
    long long res = 1;
    long long base = 2;
    long long mod = 1e9 + 7;

    while (n > 0) {
        if (n % 2 == 1) {
            res = (res * base) % mod;
        }
        base = (base * base) % mod;
        n /= 2;
    }

    return (res - 2 + mod) % mod;
}
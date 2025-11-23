long long countHousePlacements(int n) {
    if (n == 1) return 4;
    if (n == 2) return 9;

    long long mod = 1000000007;
    long long prev = 2, curr = 3;

    for (int i = 3; i <= n; i++) {
        long long next = (prev + curr) % mod;
        prev = curr;
        curr = next;
    }

    return (curr * curr) % mod;
}
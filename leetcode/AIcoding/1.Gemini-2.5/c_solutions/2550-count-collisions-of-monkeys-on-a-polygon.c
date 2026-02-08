long long power(long long base, long long exp) {
    long long res = 1;
    long long mod = 1000000007;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % mod;
        base = (base * base) % mod;
        exp /= 2;
    }
    return res;
}

int countCollisions(int n) {
    long long total_ways = power(2, n);
    long long non_collision_ways = 2; // All monkeys move clockwise OR all monkeys move anti-clockwise
    long long mod = 1000000007;

    long long collisions = (total_ways - non_collision_ways + mod) % mod;
    return (int)collisions;
}
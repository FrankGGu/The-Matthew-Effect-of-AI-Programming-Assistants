int countHousePlacements(int n) {
    long long dp_s = 1; // Number of ways to place houses on a single street ending with a space
    long long dp_h = 1; // Number of ways to place houses on a single street ending with a house
    long long mod = 1e9 + 7;

    for (int i = 2; i <= n; i++) {
        long long next_dp_s = (dp_s + dp_h) % mod;
        long long next_dp_h = dp_s % mod;
        dp_s = next_dp_s;
        dp_h = next_dp_h;
    }

    long long total_ways_single_street = (dp_s + dp_h) % mod;

    long long result = (total_ways_single_street * total_ways_single_street) % mod;

    return (int)result;
}
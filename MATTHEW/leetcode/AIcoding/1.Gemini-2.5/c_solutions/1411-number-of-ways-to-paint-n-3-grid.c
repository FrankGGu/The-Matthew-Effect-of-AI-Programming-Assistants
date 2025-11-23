int numOfWays(int n) {
    long long MOD = 1e9 + 7;

    // dp_aba represents the number of ways to paint rows such that the last row has a two-color pattern (e.g., RGR)
    // dp_abc represents the number of ways to paint rows such that the last row has a three-color pattern (e.g., RGB)

    // For N=1:
    // There are 6 patterns of type RGR (e.g., RGR, RBR, GRG, GBG, BRB, BGB)
    // There are 6 patterns of type RGB (e.g., RGB, RBG, GRB, GBR, BRG, BGR)
    long long dp_aba = 6; // Number of ways ending with a two-color pattern for current row
    long long dp_abc = 6; // Number of ways ending with a three-color pattern for current row

    for (int i = 2; i <= n; ++i) {
        // Calculate the number of ways for the current row (i) based on the previous row (i-1)

        // If the current row ends with an ABA pattern:
        // It can be placed on top of a previous ABA pattern in 3 ways.
        // It can be placed on top of a previous ABC pattern in 2 ways.
        long long next_dp_aba = (3 * dp_aba + 2 * dp_abc) % MOD;

        // If the current row ends with an ABC pattern:
        // It can be placed on top of a previous ABA pattern in 2 ways.
        // It can be placed on top of a previous ABC pattern in 2 ways.
        long long next_dp_abc = (2 * dp_aba + 2 * dp_abc) % MOD;

        dp_aba = next_dp_aba;
        dp_abc = next_dp_abc;
    }

    // The total number of ways for N rows is the sum of ways ending with ABA and ABC patterns
    return (int)((dp_aba + dp_abc) % MOD);
}
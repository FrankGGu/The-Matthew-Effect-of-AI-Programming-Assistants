var numOfWays = function(n) {
    const MOD = 10**9 + 7;

    // dp_aba represents the number of ways to paint 'i' rows such that the i-th row
    // has a pattern of two alternating colors (e.g., RGR, where colors are C1, C2, C1).
    // There are 6 such patterns for a single row (e.g., RGR, RBR, GRG, GBG, BRB, BGB).

    // dp_abc represents the number of ways to paint 'i' rows such that the i-th row
    // has a pattern of three distinct colors (e.g., RGB, where colors are C1, C2, C3).
    // There are 6 such patterns for a single row (e.g., RGB, RBG, GRB, GBR, BRG, BGR).

    // Base case for n = 1:
    let dp_aba = 6; // Number of ways for a single row with ABA pattern
    let dp_abc = 6; // Number of ways for a single row with ABC pattern

    // Iterate from the second row up to n
    for (let i = 2; i <= n; i++) {
        // Calculate the number of ways to form an ABA pattern in the current row (i)
        // based on the patterns of the previous row (i-1):
        // 1. If the previous row was ABA (e.g., GRG), there are 2 valid ABA patterns
        //    for the current row (e.g., RGR, BRB).
        // 2. If the previous row was ABC (e.g., GRB), there are 2 valid ABA patterns
        //    for the current row (e.g., RGR, BGB).
        let next_dp_aba = (2 * dp_aba + 2 * dp_abc) % MOD;

        // Calculate the number of ways to form an ABC pattern in the current row (i)
        // based on the patterns of the previous row (i-1):
        // 1. If the previous row was ABA (e.g., GRG), there are 2 valid ABC patterns
        //    for the current row (e.g., RGB, RBG).
        // 2. If the previous row was ABC (e.g., GBR), there are 3 valid ABC patterns
        //    for the current row (e.g., RGB, RBG, GRB).
        let next_dp_abc = (2 * dp_aba + 3 * dp_abc) % MOD;

        // Update the counts for the current row
        dp_aba = next_dp_aba;
        dp_abc = next_dp_abc;
    }

    // The total number of ways for n rows is the sum of ways ending in ABA and ABC patterns
    return (dp_aba + dp_abc) % MOD;
};
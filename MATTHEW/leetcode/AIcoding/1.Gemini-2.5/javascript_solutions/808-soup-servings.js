var soupServings = function(N) {
    // For very large N, the probability that soup A runs out first (or at the same time)
    // approaches 1.0. This is because soup A is, on average, served more than soup B.
    // The empirical threshold for N where the probability is effectively 1.0 (within
    // typical precision requirements like 10^-5) is around 4800.
    if (N >= 4800) {
        return 1.0;
    }

    // Convert milliliters to 'units' where 1 unit = 25ml.
    // This simplifies the state space and the serving amounts.
    // The amounts served become:
    // 1. Serve 100ml A, 0ml B  => A: -4 units, B: -0 units
    // 2. Serve 75ml A, 25ml B  => A: -3 units, B: -1 unit
    // 3. Serve 50ml A, 50ml B  => A: -2 units, B: -2 units
    // 4. Serve 25ml A, 75ml B  => A: -1 unit, B: -3 units
    let nUnits = Math.ceil(N / 25);

    // dp[i][j] will store the probability for i units of soup A and j units of soup B remaining.
    // The maximum nUnits for N=4800 is Math.ceil(4800/25) = 192.
    // So, a DP table of size (192+1) x (192+1) is sufficient.
    const dp = Array(nUnits + 1).fill(0).map(() => Array(nUnits + 1).fill(-1));

    function solve(a, b) {
        // Base case 1: Both soups are empty or have negative units.
        // This means both ran out at the same time. Contributes 0.5 to the total probability.
        if (a <= 0 && b <= 0) {
            return 0.5;
        }
        // Base case 2: Soup A is empty or has negative units, but soup B still has positive units.
        // This means soup A ran out first. Contributes 1.0 to the total probability.
        if (a <= 0) {
            return 1.0;
        }
        // Base case 3: Soup B is empty or has negative units, but soup A still has positive units.
        // This means soup B ran out first. This scenario does not contribute to the desired probability.
        if (b <= 0) {
            return 0.0;
        }

        // Check memoization table to avoid redundant calculations.
        if (dp[a][b] !== -1) {
            return dp[a][b];
        }

        // Recursive step: Calculate the probability by considering all four serving operations.
        // Each operation has an equal probability of 0.25.
        let prob = 0.25 * (
            solve(a - 4, b) +      // Serve 100ml A (4 units A)
            solve(a - 3, b - 1) +  // Serve 75ml A, 25ml B (3 units A, 1 unit B)
            solve(a - 2, b - 2) +  // Serve 50ml A, 50ml B (2 units A, 2 units B)
            solve(a - 1, b - 3)    // Serve 25ml A, 75ml B (1 unit A, 3 units B)
        );

        // Store the computed probability in the DP table.
        dp[a][b] = prob;
        return prob;
    }

    // Start the calculation with nUnits for both soup A and soup B.
    return solve(nUnits, nUnits);
};
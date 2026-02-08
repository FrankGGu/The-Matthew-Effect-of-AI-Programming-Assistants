class Solution {
    public double soupServings(int n) {
        // For very large N, the probability that soup A runs out first (or simultaneously)
        // approaches 1.0 because soup A is served more on average.
        // The problem's precision requirements typically make the answer effectively 1.0
        // for N greater than a certain threshold (around 4800).
        if (n >= 4800) {
            return 1.0;
        }

        // Scale N by dividing by 25. This simplifies the amounts served.
        // We use Math.ceil(n / 25.0) to ensure we have enough units to cover n ml.
        // (n + 24) / 25 is an integer division equivalent to ceil(n / 25.0).
        int m = (n + 24) / 25;

        // dp[i][j] will store the probability for i units of soup A and j units of soup B.
        // Each unit represents 25ml.
        double[][] dp = new double[m + 1][m + 1];

        // Base case: Both soups become empty simultaneously (i=0, j=0)
        dp[0][0] = 0.5;

        // Base cases: Soup A becomes empty first (i=0, j>0)
        // This contributes 1.0 to the desired probability.
        for (int j = 1; j <= m; j++) {
            dp[0][j] = 1.0;
        }

        // Base cases: Soup B becomes empty first (j=0, i>0)
        // In this scenario, A is not empty first, and they are not simultaneously empty.
        // This contributes 0.0 to the desired probability.
        for (int i = 1; i <= m; i++) {
            dp[i][0] = 0.0;
        }

        // Fill the DP table using bottom-up approach
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= m; j++) {
                // Each of the four serving operations has a 0.25 probability.
                // The arguments to dp[x][y] are Math.max(0, current_amount - served_amount)
                // to handle cases where the soup amount would become negative, effectively
                // treating it as 0 (empty). These Math.max(0, ...) calls will correctly
                // access the base cases (dp[0][j], dp[i][0], dp[0][0]).
                dp[i][j] = 0.25 * (
                    dp[Math.max(0, i - 4)][j] +            // Serve 100ml A (4 units A)
                    dp[Math.max(0, i - 3)][Math.max(0, j - 1)] + // Serve 75ml A (3 units A), 25ml B (1 unit B)
                    dp[Math.max(0, i - 2)][Math.max(0, j - 2)] + // Serve 50ml A (2 units A), 50ml B (2 units B)
                    dp[Math.max(0, i - 1)][Math.max(0, j - 3)]   // Serve 25ml A (1 unit A), 75ml B (3 units B)
                );
            }
        }

        // The result is the probability for the initial amounts, scaled down.
        return dp[m][m];
    }
}
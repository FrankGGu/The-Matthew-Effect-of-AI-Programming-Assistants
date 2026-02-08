class Solution {
    public int profitableSchemes(int n, int minProfit, int[] group, int[] profit) {
        int MOD = 1_000_000_007;

        // dp[j][k] represents the number of ways to achieve exactly 'j' people
        // and exactly 'k' profit.
        // The profit 'k' is capped at minProfit, meaning dp[j][minProfit]
        // stores ways to achieve minProfit or more profit.
        int[][] dp = new int[n + 1][minProfit + 1];

        // Base case: 1 way to achieve 0 people and 0 profit (by choosing no schemes)
        dp[0][0] = 1;

        // Iterate through each scheme
        for (int i = 0; i < group.length; i++) {
            int peopleNeeded = group[i];
            int currentProfit = profit[i];

            // Iterate people from max down to peopleNeeded
            // This ensures that each scheme is used at most once (0/1 knapsack property)
            for (int j = n; j >= peopleNeeded; j--) {
                // Iterate profit from max down to 0
                // 'k' here refers to the profit *before* adding the current scheme
                for (int k = minProfit; k >= 0; k--) {
                    // Calculate the new profit if this scheme is added
                    // Cap the profit at minProfit, as any profit beyond minProfit
                    // is considered equally 'profitable' for the problem's criteria.
                    int newProfit = Math.min(minProfit, k + currentProfit);

                    // Add the number of ways from the previous state (without this scheme)
                    // to the current state (with this scheme)
                    dp[j][newProfit] = (dp[j][newProfit] + dp[j - peopleNeeded][k]) % MOD;
                }
            }
        }

        // Sum up all ways to achieve at least minProfit, regardless of people used (up to n)
        // Since dp[j][minProfit] already includes all ways to get minProfit or more,
        // we just sum these values.
        int totalProfitableSchemes = 0;
        for (int j = 0; j <= n; j++) {
            totalProfitableSchemes = (totalProfitableSchemes + dp[j][minProfit]) % MOD;
        }

        return totalProfitableSchemes;
    }
}
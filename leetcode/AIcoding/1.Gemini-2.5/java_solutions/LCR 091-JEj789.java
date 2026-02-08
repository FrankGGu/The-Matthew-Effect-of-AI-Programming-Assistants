class Solution {
    public int minCost(int[][] costs) {
        if (costs == null || costs.length == 0) {
            return 0;
        }

        int n = costs.length;

        // dp0, dp1, dp2 represent the minimum cost to paint the previous house with color 0, 1, or 2 respectively.
        // Initialize with 0 as the base case before the first house.
        int dp0 = 0;
        int dp1 = 0;
        int dp2 = 0;

        for (int i = 0; i < n; i++) {
            // Calculate the minimum cost to paint the current house (i) with each color.
            // To paint house i with color 0, house i-1 must be painted with color 1 or 2.
            int current_dp0 = costs[i][0] + Math.min(dp1, dp2);
            // To paint house i with color 1, house i-1 must be painted with color 0 or 2.
            int current_dp1 = costs[i][1] + Math.min(dp0, dp2);
            // To paint house i with color 2, house i-1 must be painted with color 0 or 1.
            int current_dp2 = costs[i][2] + Math.min(dp0, dp1);

            // Update dp0, dp1, dp2 for the next iteration (i+1).
            dp0 = current_dp0;
            dp1 = current_dp1;
            dp2 = current_dp2;
        }

        // After iterating through all houses, dp0, dp1, dp2 hold the minimum costs
        // to paint all houses up to the last house (n-1) with color 0, 1, or 2 respectively.
        // The overall minimum cost is the minimum of these three.
        return Math.min(dp0, Math.min(dp1, dp2));
    }
}
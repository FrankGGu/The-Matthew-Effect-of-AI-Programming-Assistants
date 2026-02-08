class Solution {
    public int minimumOperations(String leaves) {
        int n = leaves.length();

        // dp0: minimum operations to make leaves[0...i] end with 'r' in the first 'r' section.
        // dp1: minimum operations to make leaves[0...i] end with 'y' in the middle 'y' section.
        // dp2: minimum operations to make leaves[0...i] end with 'r' in the last 'r' section.

        // Initialize for i = 0.
        // The first leaf must be 'r' in the first section. Cost is 1 if it's 'y', 0 if it's 'r'.
        int dp0 = (leaves.charAt(0) == 'y' ? 1 : 0);

        // It's impossible to have a 'y' section or a second 'r' section with only one leaf.
        // Use Integer.MAX_VALUE to represent infinity.
        int dp1 = Integer.MAX_VALUE;
        int dp2 = Integer.MAX_VALUE;

        for (int i = 1; i < n; i++) {
            int new_dp0, new_dp1, new_dp2;

            // Cost to change current leaf leaves[i] to 'r'
            int cost_to_r = (leaves.charAt(i) == 'y' ? 1 : 0);
            // Cost to change current leaf leaves[i] to 'y'
            int cost_to_y = (leaves.charAt(i) == 'r' ? 1 : 0);

            // Calculate new_dp0: current leaf is 'r' in the first section.
            // It must extend the previous first 'r' section.
            new_dp0 = dp0 + cost_to_r;

            // Calculate new_dp1: current leaf is 'y' in the middle section.
            // It can either transition from the first 'r' section (dp0)
            // or extend the middle 'y' section (dp1).
            // If dp0 or dp1 is MAX_VALUE, Math.min correctly handles it.
            if (dp0 == Integer.MAX_VALUE && dp1 == Integer.MAX_VALUE) { // Both previous states unreachable
                new_dp1 = Integer.MAX_VALUE;
            } else {
                new_dp1 = Math.min(dp0, dp1) + cost_to_y;
            }

            // Calculate new_dp2: current leaf is 'r' in the last section.
            // It can either transition from the middle 'y' section (dp1)
            // or extend the last 'r' section (dp2).
            // If dp1 or dp2 is MAX_VALUE, Math.min correctly handles it.
            if (dp1 == Integer.MAX_VALUE && dp2 == Integer.MAX_VALUE) { // Both previous states unreachable
                new_dp2 = Integer.MAX_VALUE;
            } else {
                new_dp2 = Math.min(dp1, dp2) + cost_to_r;
            }

            // Update dp values for the next iteration
            dp0 = new_dp0;
            dp1 = new_dp1;
            dp2 = new_dp2;
        }

        // The final answer is dp2 for the last leaf (n-1).
        // The problem requires at least one 'r', at least one 'y', and at least one 'r'.
        // This is implicitly handled by the initialization of dp1 and dp2 to MAX_VALUE,
        // ensuring that dp1 can only become finite after dp0 is finite, and dp2 after dp1 is finite.
        return dp2;
    }
}
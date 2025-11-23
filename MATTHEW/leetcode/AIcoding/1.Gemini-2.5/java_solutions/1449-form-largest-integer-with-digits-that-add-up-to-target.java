import java.util.Arrays;

class Solution {
    public String largestNumber(int[] cost, int target) {
        // dp[i] stores the maximum number of digits (length) that can be formed with cost i.
        int[] dp = new int[target + 1];

        // Initialize dp[0] to 0, meaning 0 cost can form a number with 0 digits.
        // Initialize all other dp[i] to a very small negative number to indicate unreachable.
        // Using Integer.MIN_VALUE / 2 to avoid potential overflow issues if adding/subtracting 1.
        Arrays.fill(dp, Integer.MIN_VALUE / 2);
        dp[0] = 0;

        // Fill the DP table
        for (int t = 1; t <= target; t++) {
            for (int digit = 1; digit <= 9; digit++) {
                int digitCost = cost[digit - 1];

                if (t >= digitCost) {
                    // If dp[t - digitCost] is reachable, we can potentially form a longer number
                    // by adding the current digit.
                    dp[t] = Math.max(dp[t], dp[t - digitCost] + 1);
                }
            }
        }

        // If dp[target] is still 0 or negative (unreachable), it means we cannot form any number
        // for the given target cost. Return "0".
        // Note: If target=0, dp[0] is 0. This means 0 digits. The problem asks for an integer,
        // so "0" is the appropriate return for an empty number or unreachable target.
        if (dp[target] <= 0) {
            return "0";
        }

        // Reconstruct the largest number string
        StringBuilder sb = new StringBuilder();
        int currentTarget = target;

        // Iterate digits from 9 down to 1 to prioritize larger digits
        // when multiple choices lead to the same maximum length.
        for (int digit = 9; digit >= 1; digit--) {
            int digitCost = cost[digit - 1];

            // While we can use this digit and it leads to the optimal length for the currentTarget
            while (currentTarget >= digitCost && dp[currentTarget] == dp[currentTarget - digitCost] + 1) {
                sb.append(digit);
                currentTarget -= digitCost;
            }
        }

        return sb.toString();
    }
}
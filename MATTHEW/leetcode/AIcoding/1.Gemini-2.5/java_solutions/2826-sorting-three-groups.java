import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

class Solution {
    public int minimumOperations(List<Integer> nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        // dp[i][g] stores the maximum length of a valid subsequence ending at index i,
        // where nums.get(i) is assigned to group g (0 for group 1, 1 for group 2, 2 for group 3).
        // dp[i][0] -> nums.get(i) in group 1
        // dp[i][1] -> nums.get(i) in group 2
        // dp[i][2] -> nums.get(i) in group 3
        int[][] dp = new int[n][3];

        int maxKept = 0;

        for (int i = 0; i < n; i++) {
            // Base case: current element itself forms a subsequence of length 1 in any group
            dp[i][0] = 1; // nums.get(i) in group 1
            dp[i][1] = 1; // nums.get(i) in group 2
            dp[i][2] = 1; // nums.get(i) in group 3

            for (int j = 0; j < i; j++) {
                int prevNum = nums.get(j);
                int currNum = nums.get(i);

                // If nums.get(i) is in Group 1
                // Previous element nums.get(j) must be in Group 1, and nums.get(j) <= nums.get(i)
                if (prevNum <= currNum) {
                    dp[i][0] = Math.max(dp[i][0], 1 + dp[j][0]);
                }

                // If nums.get(i) is in Group 2
                // Previous element nums.get(j) can be in Group 1 or Group 2.
                // If nums.get(j) in Group 1: no value constraint on nums.get(j) vs nums.get(i)
                dp[i][1] = Math.max(dp[i][1], 1 + dp[j][0]);
                // If nums.get(j) in Group 2: nums.get(j) must be <= nums.get(i)
                if (prevNum <= currNum) {
                    dp[i][1] = Math.max(dp[i][1], 1 + dp[j][1]);
                }

                // If nums.get(i) is in Group 3
                // Previous element nums.get(j) can be in Group 1, Group 2, or Group 3.
                // If nums.get(j) in Group 1: no value constraint
                dp[i][2] = Math.max(dp[i][2], 1 + dp[j][0]);
                // If nums.get(j) in Group 2: no value constraint
                dp[i][2] = Math.max(dp[i][2], 1 + dp[j][1]);
                // If nums.get(j) in Group 3: nums.get(j) must be <= nums.get(i)
                if (prevNum <= currNum) {
                    dp[i][2] = Math.max(dp[i][2], 1 + dp[j][2]);
                }
            }

            maxKept = Math.max(maxKept, dp[i][0]);
            maxKept = Math.max(maxKept, dp[i][1]);
            maxKept = Math.max(maxKept, dp[i][2]);
        }

        return n - maxKept;
    }
}
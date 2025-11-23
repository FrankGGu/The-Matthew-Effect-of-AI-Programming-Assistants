public class Solution {

import java.util.Arrays;

public class Solution {
    public int minimumDifference(int[] nums) {
        int n = nums.length;
        int totalSum = Arrays.stream(nums).sum();
        boolean[][] dp = new boolean[n + 1][totalSum + 1];
        dp[0][0] = true;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= totalSum; j++) {
                if (dp[i][j]) {
                    dp[i + 1][j + nums[i]] = true;
                    dp[i + 1][j] = true;
                }
            }
        }

        int minDiff = Integer.MAX_VALUE;
        for (int j = 0; j <= totalSum; j++) {
            if (dp[n][j]) {
                int diff = Math.abs((totalSum - j) - j);
                minDiff = Math.min(minDiff, diff);
            }
        }

        return minDiff;
    }
}
}
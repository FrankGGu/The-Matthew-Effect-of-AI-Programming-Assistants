class Solution {
    public int deleteAndEarn(int[] nums) {
        int maxVal = 0;
        for (int num : nums) {
            maxVal = Math.max(maxVal, num);
        }

        int[] totalPoints = new int[maxVal + 1];
        for (int num : nums) {
            totalPoints[num] += num;
        }

        // dp[i] represents the maximum points that can be earned considering numbers up to i.
        // This is a variation of the House Robber problem.
        // If we choose to take number i, we earn totalPoints[i] and cannot take i-1.
        // So, the points from previous numbers would be dp[i-2].
        // If we choose not to take number i, the points would be dp[i-1].
        // dp[i] = Math.max(dp[i-1], dp[i-2] + totalPoints[i])

        if (maxVal == 0) {
            return 0;
        }

        int[] dp = new int[maxVal + 1];
        dp[0] = 0;
        dp[1] = totalPoints[1];

        for (int i = 2; i <= maxVal; i++) {
            dp[i] = Math.max(dp[i - 1], dp[i - 2] + totalPoints[i]);
        }

        return dp[maxVal];
    }
}
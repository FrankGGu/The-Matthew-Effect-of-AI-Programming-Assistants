class Solution {
    public int maxFactorScore(int[] nums) {
        long[] dp = new long[nums.length];
        for (int i = 0; i < nums.length; i++) {
            dp[i] = 1;
            for (int j = 1; j * j <= nums[i]; j++) {
                if (nums[i] % j == 0) {
                    if (j != 1) {
                        dp[i] += j;
                    }
                    if (j * j != nums[i]) {
                        dp[i] += nums[i] / j;
                    }
                }
            }
        }

        long maxScore = 0;
        for (long score : dp) {
            maxScore = Math.max(maxScore, score);
        }

        return (int) maxScore;
    }
}
class Solution {
    public int maxSumDivisibleByThree(int[] nums) {
        int[] dp = new int[3];
        dp[0] = 0;
        dp[1] = Integer.MIN_VALUE;
        dp[2] = Integer.MIN_VALUE;

        for (int num : nums) {
            int[] tempDp = dp.clone();

            for (int j = 0; j < 3; j++) {
                if (tempDp[j] != Integer.MIN_VALUE) {
                    int currentSum = tempDp[j] + num;
                    int remainder = currentSum % 3;
                    dp[remainder] = Math.max(dp[remainder], currentSum);
                }
            }
        }

        return dp[0];
    }
}
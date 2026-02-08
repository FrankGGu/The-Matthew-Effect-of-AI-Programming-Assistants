class Solution {
    public int maximumAndSum(int[] nums, int numSlots) {
        int n = nums.length;
        int[][] dp = new int[1 << n][numSlots + 1];
        int maxSum = 0;

        for (int i = 0; i < (1 << n); i++) {
            int count = Integer.bitCount(i);
            if (count > numSlots) continue;

            for (int j = 0; j < n; j++) {
                if ((i & (1 << j)) == 0) {
                    int newMask = i | (1 << j);
                    for (int k = 1; k <= numSlots; k++) {
                        dp[newMask][k] = Math.max(dp[newMask][k], dp[i][k] + (k == count ? nums[j] : 0));
                        maxSum = Math.max(maxSum, dp[newMask][k]);
                    }
                }
            }
        }
        return maxSum;
    }
}
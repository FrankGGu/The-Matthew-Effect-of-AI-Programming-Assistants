class Solution {
    public int maxSumDivThree(int[] nums) {
        int[] dp = new int[]{0, Integer.MIN_VALUE, Integer.MIN_VALUE};
        for (int num : nums) {
            int[] newDp = new int[3];
            for (int i = 0; i < 3; ++i) {
                newDp[(i + num) % 3] = Math.max(dp[(i + num) % 3], dp[i] + num);
            }
            dp = newDp;
        }
        return dp[0];
    }
}
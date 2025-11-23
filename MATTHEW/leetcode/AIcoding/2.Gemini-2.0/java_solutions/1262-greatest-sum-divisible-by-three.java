class Solution {
    public int maxSumDivisibleByThree(int[] nums) {
        int[] dp = new int[3];
        for (int num : nums) {
            int[] newDp = new int[3];
            for (int i = 0; i < 3; i++) {
                newDp[i] = dp[i];
            }
            for (int i = 0; i < 3; i++) {
                int rem = (i + num) % 3;
                newDp[rem] = Math.max(newDp[rem], dp[i] + num);
            }
            dp = newDp;
        }
        return dp[0];
    }
}
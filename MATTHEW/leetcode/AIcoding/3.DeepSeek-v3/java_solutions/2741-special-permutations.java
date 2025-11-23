class Solution {
    private int MOD = 1_000_000_007;
    private int n;
    private int[] nums;
    private Integer[][] dp;

    public int specialPerm(int[] nums) {
        this.n = nums.length;
        this.nums = nums;
        this.dp = new Integer[n][1 << n];
        return backtrack(0, 0);
    }

    private int backtrack(int prevIndex, int mask) {
        if (mask == (1 << n) - 1) {
            return 1;
        }
        if (dp[prevIndex][mask] != null) {
            return dp[prevIndex][mask];
        }
        int res = 0;
        for (int i = 0; i < n; i++) {
            if ((mask & (1 << i)) == 0) {
                if (mask == 0 || nums[prevIndex] % nums[i] == 0 || nums[i] % nums[prevIndex] == 0) {
                    res = (res + backtrack(i, mask | (1 << i))) % MOD;
                }
            }
        }
        dp[prevIndex][mask] = res;
        return res;
    }
}
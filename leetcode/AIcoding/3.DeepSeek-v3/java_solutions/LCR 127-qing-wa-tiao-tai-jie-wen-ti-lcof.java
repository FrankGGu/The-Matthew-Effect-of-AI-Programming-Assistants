class Solution {
    public int trainWays(int num) {
        if (num == 0) return 1;
        if (num == 1) return 1;
        int[] dp = new int[num + 1];
        dp[0] = 1;
        dp[1] = 1;
        for (int i = 2; i <= num; i++) {
            dp[i] = (dp[i - 1] + dp[i - 2]) % 1000000007;
        }
        return dp[num];
    }
}
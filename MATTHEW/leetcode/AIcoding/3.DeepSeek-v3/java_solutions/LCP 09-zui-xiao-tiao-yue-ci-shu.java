class Solution {
    public int minJump(int[] jump) {
        int n = jump.length;
        int[] dp = new int[n];
        Arrays.fill(dp, -1);
        dp[n - 1] = 1;
        for (int i = n - 2; i >= 0; i--) {
            if (i + jump[i] >= n) {
                dp[i] = 1;
            } else {
                dp[i] = dp[i + jump[i]] == -1 ? -1 : dp[i + jump[i]] + 1;
            }
            for (int j = i + 1; j < n && j < i + jump[i] && dp[j] != -1; j++) {
                if (dp[i] == -1 || dp[j] + 1 < dp[i]) {
                    dp[i] = dp[j] + 1;
                }
            }
        }
        return dp[0];
    }
}
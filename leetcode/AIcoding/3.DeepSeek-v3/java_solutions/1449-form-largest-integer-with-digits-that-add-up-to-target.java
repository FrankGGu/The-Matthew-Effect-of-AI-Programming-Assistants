class Solution {
    public String largestNumber(int[] cost, int target) {
        int[] dp = new int[target + 1];
        Arrays.fill(dp, Integer.MIN_VALUE);
        dp[0] = 0;
        for (int t = 1; t <= target; t++) {
            for (int i = 0; i < 9; i++) {
                if (t >= cost[i]) {
                    dp[t] = Math.max(dp[t], dp[t - cost[i]] + 1);
                }
            }
        }
        if (dp[target] < 0) {
            return "0";
        }
        StringBuilder res = new StringBuilder();
        for (int i = 8; i >= 0; i--) {
            while (target >= cost[i] && dp[target] == dp[target - cost[i]] + 1) {
                res.append(i + 1);
                target -= cost[i];
            }
        }
        return res.toString();
    }
}
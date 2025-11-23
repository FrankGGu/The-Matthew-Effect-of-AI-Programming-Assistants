class Solution {
    public String largestNumber(int[] cost, int target) {
        String[] dp = new String[target + 1];
        dp[0] = "";
        for (int i = 1; i <= target; i++) {
            dp[i] = null;
            for (int j = 0; j < cost.length; j++) {
                if (i >= cost[j] && dp[i - cost[j]] != null) {
                    String current = dp[i - cost[j]] + (j + 1);
                    if (dp[i] == null || current.length() > dp[i].length() ||
                            (current.length() == dp[i].length() && current.compareTo(dp[i]) > 0)) {
                        dp[i] = current;
                    }
                }
            }
        }
        return dp[target] == null ? "0" : dp[target];
    }
}
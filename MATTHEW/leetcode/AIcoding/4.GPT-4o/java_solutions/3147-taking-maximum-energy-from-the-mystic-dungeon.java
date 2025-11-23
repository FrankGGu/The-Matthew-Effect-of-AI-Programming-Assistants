class Solution {
    public int maxEnergy(int[] energy, int[][] actions) {
        int n = energy.length;
        int[] dp = new int[n + 1];

        for (int i = 0; i < n; i++) {
            dp[i + 1] = dp[i] + energy[i];
            for (int[] action : actions) {
                if (action[0] == i + 1) {
                    dp[i + 1] = Math.max(dp[i + 1], dp[action[1]] + action[2]);
                }
            }
        }

        return dp[n];
    }
}
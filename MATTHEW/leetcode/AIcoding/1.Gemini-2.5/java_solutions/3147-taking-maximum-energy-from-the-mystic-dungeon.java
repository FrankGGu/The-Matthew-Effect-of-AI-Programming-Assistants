class Solution {
    public long maximumEnergy(int[] energy, int k) {
        int n = energy.length;
        long[] dp = new long[n];
        long maxEnergy = Long.MIN_VALUE;

        for (int i = n - 1; i >= 0; i--) {
            dp[i] = energy[i];
            if (i + k < n) {
                dp[i] += dp[i + k];
            }
            maxEnergy = Math.max(maxEnergy, dp[i]);
        }

        return maxEnergy;
    }
}
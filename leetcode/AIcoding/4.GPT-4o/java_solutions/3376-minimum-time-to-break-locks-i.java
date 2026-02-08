public class Solution {
    public int minTimeToUnlock(int[] locks) {
        int n = locks.length;
        int[] dp = new int[1 << n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) == 0) {
                    int nextMask = mask | (1 << i);
                    dp[nextMask] = Math.min(dp[nextMask], dp[mask] + locks[i]);
                }
            }
        }

        return dp[(1 << n) - 1];
    }
}
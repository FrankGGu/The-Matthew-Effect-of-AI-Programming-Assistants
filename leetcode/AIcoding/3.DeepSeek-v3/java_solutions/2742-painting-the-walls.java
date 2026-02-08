class Solution {
    public int paintWalls(int[] cost, int[] time) {
        int n = cost.length;
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE / 2);
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            int c = cost[i];
            int t = time[i] + 1;
            for (int j = n; j >= 0; j--) {
                int newJ = Math.min(j + t, n);
                dp[newJ] = Math.min(dp[newJ], dp[j] + c);
            }
        }

        return dp[n];
    }
}
class Solution {
    public long minimumTotalPrice(int n, int[][] trips) {
        long[] dp = new long[n + 1];
        long[] cnt = new long[n + 1];

        for (int[] trip : trips) {
            int start = trip[0], end = trip[1];
            cnt[start]++;
            cnt[end + 1]--;
        }

        for (int i = 1; i <= n; i++) {
            cnt[i] += cnt[i - 1];
            dp[i] = dp[i - 1] + cnt[i] * 2; // cost without discount
            if (i >= 2) {
                dp[i] = Math.min(dp[i], dp[i - 2]); // cost with discount
            }
        }

        return dp[n] / 2; // dividing by 2 since each trip is counted twice
    }
}
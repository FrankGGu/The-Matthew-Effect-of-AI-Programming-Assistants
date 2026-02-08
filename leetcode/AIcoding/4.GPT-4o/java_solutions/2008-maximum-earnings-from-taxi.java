class Solution {
    public long maxTaxiEarnings(int n, int[][] rides) {
        long[] dp = new long[n + 1];
        Arrays.sort(rides, (a, b) -> Integer.compare(a[1], b[1]));

        for (int[] ride : rides) {
            int start = ride[0];
            int end = ride[1];
            int tip = ride[2];
            dp[end] = Math.max(dp[end], dp[start] + end - start + tip);
        }

        for (int i = 1; i <= n; i++) {
            dp[i] = Math.max(dp[i], dp[i - 1]);
        }

        return dp[n];
    }
}
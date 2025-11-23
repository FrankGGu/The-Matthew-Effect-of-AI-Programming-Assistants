class Solution {
    public long getMaxFunctionValue(List<Integer> receiver, long k) {
        int n = receiver.size();
        int logK = 64 - Long.numberOfLeadingZeros(k);
        long[][] dp = new long[n][logK + 1];
        int[][] next = new int[n][logK + 1];

        for (int i = 0; i < n; i++) {
            next[i][0] = receiver.get(i);
            dp[i][0] = receiver.get(i);
        }

        for (int j = 1; j <= logK; j++) {
            for (int i = 0; i < n; i++) {
                next[i][j] = next[next[i][j - 1]][j - 1];
                dp[i][j] = dp[i][j - 1] + dp[next[i][j - 1]][j - 1];
            }
        }

        long ans = 0;
        for (int start = 0; start < n; start++) {
            long currentSum = start;
            int current = start;
            long remainingK = k;

            for (int j = logK; j >= 0; j--) {
                if ((remainingK & (1L << j)) != 0) {
                    currentSum += dp[current][j];
                    current = next[current][j];
                    remainingK -= (1L << j);
                }
            }
            ans = Math.max(ans, currentSum);
        }

        return ans;
    }
}
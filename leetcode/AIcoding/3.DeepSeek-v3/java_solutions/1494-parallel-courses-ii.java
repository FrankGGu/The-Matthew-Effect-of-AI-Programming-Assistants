class Solution {
    public int minNumberOfSemesters(int n, int[][] relations, int k) {
        int[] pre = new int[n];
        for (int[] r : relations) {
            int prev = r[0] - 1;
            int next = r[1] - 1;
            pre[next] |= 1 << prev;
        }

        int[] dp = new int[1 << n];
        Arrays.fill(dp, n);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            if (dp[mask] == n) continue;

            int available = 0;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) == 0 && (pre[i] & mask) == pre[i]) {
                    available |= 1 << i;
                }
            }

            for (int subset = available; subset > 0; subset = (subset - 1) & available) {
                if (Integer.bitCount(subset) <= k) {
                    dp[mask | subset] = Math.min(dp[mask | subset], dp[mask] + 1);
                }
            }
        }

        return dp[(1 << n) - 1];
    }
}
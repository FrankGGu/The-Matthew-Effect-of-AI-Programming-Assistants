class Solution {
    public int minNumberOfSemesters(int n, int[][] dependencies, int k) {
        int[] pre = new int[n];
        for (int[] dependency : dependencies) {
            int u = dependency[1] - 1;
            int v = dependency[0] - 1;
            pre[u] |= (1 << v);
        }

        int[] dp = new int[1 << n];
        Arrays.fill(dp, n);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            int canTake = 0;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) == 0 && (pre[i] & mask) == pre[i]) {
                    canTake |= (1 << i);
                }
            }

            for (int submask = canTake; submask > 0; submask = (submask - 1) & canTake) {
                if (Integer.bitCount(submask) <= k) {
                    dp[mask | submask] = Math.min(dp[mask | submask], dp[mask] + 1);
                }
            }
        }

        return dp[(1 << n) - 1];
    }
}
import java.util.Arrays;

class Solution {
    private static final int MOD = 1000000007;

    public int numberOfWays(int[] hats) {
        int n = hats.length;
        int m = 40;
        @SuppressWarnings("unchecked")
        java.util.List<Integer>[] hatToPersons = new java.util.List[m + 1];
        for (int i = 1; i <= m; i++) {
            hatToPersons[i] = new java.util.ArrayList<>();
        }
        for (int i = 0; i < n; i++) {
            for (int hat : hats[i] > 40 ? new int[0] : new int[]{hats[i]}) {
                hatToPersons[hat].add(i);
            }
        }

        int[][] dp = new int[m + 1][1 << n];
        dp[0][0] = 1;

        for (int i = 1; i <= m; i++) {
            for (int mask = 0; mask < (1 << n); mask++) {
                dp[i][mask] = dp[i - 1][mask];
                for (int person : hatToPersons[i]) {
                    if ((mask & (1 << person)) != 0) {
                        dp[i][mask] = (dp[i][mask] + dp[i - 1][mask ^ (1 << person)]) % MOD;
                    }
                }
            }
        }

        return dp[m][(1 << n) - 1];
    }
}
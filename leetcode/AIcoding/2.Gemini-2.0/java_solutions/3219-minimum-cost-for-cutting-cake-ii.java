import java.util.Arrays;

class Solution {
    public int minCost(int[] cuts, int cakeLength) {
        int n = cuts.length;
        int[] newCuts = new int[n + 2];
        newCuts[0] = 0;
        newCuts[n + 1] = cakeLength;
        System.arraycopy(cuts, 0, newCuts, 1, n);
        Arrays.sort(newCuts);

        int[][] dp = new int[n + 2][n + 2];

        for (int len = 2; len <= n + 1; len++) {
            for (int i = 0; i <= n + 1 - len; i++) {
                int j = i + len;
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = i + 1; k < j; k++) {
                    dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + newCuts[j] - newCuts[i]);
                }
            }
        }

        return dp[0][n + 1];
    }
}
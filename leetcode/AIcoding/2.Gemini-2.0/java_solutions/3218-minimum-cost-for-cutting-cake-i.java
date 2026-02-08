import java.util.Arrays;

class Solution {
    public int minCost(int n, int[] cuts) {
        int m = cuts.length;
        int[] newCuts = new int[m + 2];
        newCuts[0] = 0;
        newCuts[m + 1] = n;
        System.arraycopy(cuts, 0, newCuts, 1, m);
        Arrays.sort(newCuts);

        int[][] dp = new int[m + 2][m + 2];

        for (int len = 2; len <= m + 1; len++) {
            for (int i = 0; i <= m + 1 - len; i++) {
                int j = i + len;
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = i + 1; k < j; k++) {
                    dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + newCuts[j] - newCuts[i]);
                }
            }
        }

        return dp[0][m + 1];
    }
}
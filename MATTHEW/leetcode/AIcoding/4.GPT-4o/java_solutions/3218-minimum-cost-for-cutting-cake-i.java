import java.util.Arrays;

class Solution {
    public int minCost(int n, int[] cuts) {
        Arrays.sort(cuts);
        int m = cuts.length;
        int[][] dp = new int[m + 2][m + 2];
        int[] newCuts = new int[m + 2];
        newCuts[0] = 0;
        newCuts[m + 1] = n;
        for (int i = 1; i <= m; i++) {
            newCuts[i] = cuts[i - 1];
        }

        for (int length = 2; length <= m + 1; length++) {
            for (int i = 0; i + length <= m + 1; i++) {
                int j = i + length;
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = i + 1; k < j; k++) {
                    dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + newCuts[j] - newCuts[i]);
                }
            }
        }

        return dp[0][m + 1];
    }
}
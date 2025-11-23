import java.util.Arrays;

public class Solution {
    public int minCost(int n, int[] cuts) {
        Arrays.sort(cuts);
        int[][] dp = new int[cuts.length + 2][cuts.length + 2];
        int[] allCuts = new int[cuts.length + 2];
        allCuts[0] = 0;
        allCuts[cuts.length + 1] = n;
        for (int i = 1; i <= cuts.length; i++) {
            allCuts[i] = cuts[i - 1];
        }
        for (int len = 2; len < allCuts.length; len++) {
            for (int i = 0; i + len < allCuts.length; i++) {
                int j = i + len;
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = i + 1; k < j; k++) {
                    dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + allCuts[j] - allCuts[i]);
                }
            }
        }
        return dp[0][cuts.length + 1];
    }
}
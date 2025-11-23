public class Solution {

import java.util.Arrays;

public class Solution {
    public int minCost(int n, int[] cuts) {
        int[] newCuts = new int[cuts.length + 2];
        System.arraycopy(cuts, 0, newCuts, 1, cuts.length);
        newCuts[0] = 0;
        newCuts[newCuts.length - 1] = n;
        Arrays.sort(newCuts);
        int[][] dp = new int[newCuts.length][newCuts.length];

        for (int i = 0; i < newCuts.length; i++) {
            Arrays.fill(dp[i], 0);
        }

        for (int length = 2; length < newCuts.length; length++) {
            for (int i = 0; i + length < newCuts.length; i++) {
                int j = i + length;
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = i + 1; k < j; k++) {
                    dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + newCuts[j] - newCuts[i]);
                }
            }
        }

        return dp[0][newCuts.length - 1];
    }
}
}
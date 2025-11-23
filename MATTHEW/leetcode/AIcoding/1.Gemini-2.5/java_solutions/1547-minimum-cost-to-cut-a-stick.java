import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int minCost(int n, int[] cuts) {
        List<Integer> allCuts = new ArrayList<>();
        allCuts.add(0);
        for (int cut : cuts) {
            allCuts.add(cut);
        }
        allCuts.add(n);
        Collections.sort(allCuts);

        int m = allCuts.size();
        int[][] dp = new int[m][m];

        for (int gap = 2; gap < m; gap++) {
            for (int i = 0; i < m - gap; i++) {
                int j = i + gap;
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = i + 1; k < j; k++) {
                    int currentCost = (allCuts.get(j) - allCuts.get(i)) + dp[i][k] + dp[k][j];
                    dp[i][j] = Math.min(dp[i][j], currentCost);
                }
            }
        }

        return dp[0][m - 1];
    }
}
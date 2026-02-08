public class Solution {

import java.util.*;

public class Solution {
    public int minCost(int n, int[] queries) {
        Set<Integer> cutPoints = new HashSet<>();
        for (int q : queries) {
            cutPoints.add(q);
        }
        List<Integer> sorted = new ArrayList<>(cutPoints);
        Collections.sort(sorted);
        sorted.add(0, 0);
        sorted.add(n);
        int m = sorted.size();
        int[][] dp = new int[m][m];
        for (int i = 0; i < m - 1; i++) {
            dp[i][i + 1] = 0;
        }
        for (int length = 2; length < m; length++) {
            for (int i = 0; i + length < m; i++) {
                int j = i + length;
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = i + 1; k < j; k++) {
                    dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k][j] + sorted[j] - sorted[i]);
                }
            }
        }
        return dp[0][m - 1];
    }
}
}
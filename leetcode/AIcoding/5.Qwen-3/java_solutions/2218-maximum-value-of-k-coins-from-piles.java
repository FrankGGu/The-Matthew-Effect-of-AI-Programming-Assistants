public class Solution {

import java.util.*;

public class Solution {
    public int maxValueOfKCoinsFromPiles(List<List<Integer>> piles, int k) {
        int n = piles.size();
        int[][] dp = new int[k + 1][n];

        for (int i = 0; i < n; i++) {
            List<Integer> pile = piles.get(i);
            int m = pile.size();
            int[] prev = dp[i - 1];
            int[] curr = dp[i];

            for (int j = 0; j <= k; j++) {
                curr[j] = prev[j];
            }

            int sum = 0;
            for (int t = 0; t < m && t <= k; t++) {
                sum += pile.get(t);
                for (int j = t + 1; j <= k; j++) {
                    curr[j] = Math.max(curr[j], prev[j - t - 1] + sum);
                }
            }
        }

        return dp[n - 1][k];
    }
}
}
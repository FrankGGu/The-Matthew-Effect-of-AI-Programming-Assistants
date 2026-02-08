public class Solution {

import java.util.*;

public class Solution {
    public int minimumChanges(String s, int k) {
        int n = s.length();
        int[][] cost = new int[n][n];

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int left = i, right = j;
                int c = 0;
                while (left < right) {
                    if (s.charAt(left) != s.charAt(right)) {
                        ++c;
                    }
                    ++left;
                    --right;
                }
                cost[i][j] = c;
            }
        }

        int[][] dp = new int[k + 1][n];
        for (int i = 0; i <= k; ++i) {
            Arrays.fill(dp[i], -1);
        }

        for (int i = 0; i < n; ++i) {
            dp[1][i] = cost[0][i];
        }

        for (int m = 2; m <= k; ++m) {
            for (int i = 0; i < n; ++i) {
                for (int j = m - 1; j <= i; ++j) {
                    if (dp[m - 1][j] != -1) {
                        if (dp[m][i] == -1 || dp[m][i] > dp[m - 1][j] + cost[j + 1][i]) {
                            dp[m][i] = dp[m - 1][j] + cost[j + 1][i];
                        }
                    }
                }
            }
        }

        return dp[k][n - 1];
    }
}
}
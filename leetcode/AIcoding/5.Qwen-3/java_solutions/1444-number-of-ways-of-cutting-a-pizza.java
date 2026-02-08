public class Solution {

import java.util.*;

public class Solution {
    public int ways(String[] pizza, int k) {
        int m = pizza.length;
        int n = pizza[0].length();
        int[][] dp = new int[m][n];
        int[][] prefix = new int[m + 1][n + 1];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                prefix[i + 1][j + 1] = (pizza[i].charAt(j) == 'A' ? 1 : 0) + prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j];
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                dp[i][j] = 1;
            }
        }

        for (int step = 1; step < k; step++) {
            int[][] newDp = new int[m][n];
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    for (int x = i; x < m; x++) {
                        for (int y = j; y < n; y++) {
                            if (getApple(prefix, i, j, x, y) > 0) {
                                if (x == m - 1 && y == n - 1) {
                                    newDp[i][j] += 1;
                                } else {
                                    newDp[i][j] += dp[x][y];
                                }
                            }
                        }
                    }
                }
            }
            dp = newDp;
        }

        return dp[0][0];
    }

    private int getApple(int[][] prefix, int r1, int c1, int r2, int c2) {
        return prefix[r2 + 1][c2 + 1] - prefix[r1][c2 + 1] - prefix[r2 + 1][c1] + prefix[r1][c1];
    }
}
}
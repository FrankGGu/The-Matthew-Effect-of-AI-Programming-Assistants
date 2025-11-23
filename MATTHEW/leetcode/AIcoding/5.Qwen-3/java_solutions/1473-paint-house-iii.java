public class Solution {
    public int minCost(int[] houses, int[][] cost, int m, int n, int k) {
        int[][][] dp = new int[m][n][k];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int l = 0; l < k; l++) {
                    dp[i][j][l] = Integer.MAX_VALUE;
                }
            }
        }

        for (int j = 0; j < n; j++) {
            dp[0][j][0] = houses[0] == 0 ? cost[0][j] : (houses[0] - 1 == j ? 0 : Integer.MAX_VALUE);
        }

        for (int i = 1; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int l = 0; l < k; l++) {
                    if (houses[i] != 0 && houses[i] - 1 != j) {
                        continue;
                    }
                    for (int prev = 0; prev < n; prev++) {
                        for (int prevColor = 0; prevColor < k; prevColor++) {
                            if (prevColor == l) {
                                continue;
                            }
                            if (dp[i - 1][prev][prevColor] == Integer.MAX_VALUE) {
                                continue;
                            }
                            int currentCost = houses[i] == 0 ? cost[i][j] : 0;
                            dp[i][j][l] = Math.min(dp[i][j][l], dp[i - 1][prev][prevColor] + currentCost);
                        }
                    }
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int j = 0; j < n; j++) {
            for (int l = 0; l < k; l++) {
                result = Math.min(result, dp[m - 1][j][l]);
            }
        }

        return result == Integer.MAX_VALUE ? -1 : result;
    }
}
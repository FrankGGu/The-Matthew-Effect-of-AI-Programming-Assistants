class Solution {
    public int minCost(int[] houses, int[][] cost, int m, int n, int target) {
        int[][][] dp = new int[m][n + 1][target + 1];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j <= n; j++) {
                Arrays.fill(dp[i][j], Integer.MAX_VALUE);
            }
        }

        if (houses[0] == 0) {
            for (int k = 1; k <= n; k++) {
                dp[0][k][1] = cost[0][k - 1];
            }
        } else {
            dp[0][houses[0]][1] = 0;
        }

        for (int i = 1; i < m; i++) {
            if (houses[i] == 0) {
                for (int prevColor = 1; prevColor <= n; prevColor++) {
                    for (int prevBlocks = 1; prevBlocks <= target; prevBlocks++) {
                        if (dp[i - 1][prevColor][prevBlocks] == Integer.MAX_VALUE) continue;
                        for (int currColor = 1; currColor <= n; currColor++) {
                            int newBlocks = prevBlocks + (currColor == prevColor ? 0 : 1);
                            if (newBlocks > target) continue;
                            dp[i][currColor][newBlocks] = Math.min(dp[i][currColor][newBlocks], 
                                                                  dp[i - 1][prevColor][prevBlocks] + cost[i][currColor - 1]);
                        }
                    }
                }
            } else {
                int currColor = houses[i];
                for (int prevColor = 1; prevColor <= n; prevColor++) {
                    for (int prevBlocks = 1; prevBlocks <= target; prevBlocks++) {
                        if (dp[i - 1][prevColor][prevBlocks] == Integer.MAX_VALUE) continue;
                        int newBlocks = prevBlocks + (currColor == prevColor ? 0 : 1);
                        if (newBlocks > target) continue;
                        dp[i][currColor][newBlocks] = Math.min(dp[i][currColor][newBlocks], 
                                                              dp[i - 1][prevColor][prevBlocks]);
                    }
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int color = 1; color <= n; color++) {
            result = Math.min(result, dp[m - 1][color][target]);
        }
        return result == Integer.MAX_VALUE ? -1 : result;
    }
}
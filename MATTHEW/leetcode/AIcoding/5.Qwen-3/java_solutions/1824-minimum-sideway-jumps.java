public class Solution {
    public int minSidewaysJumps(int n, int[][] roads) {
        int[] dp = new int[3];
        for (int i = 0; i < n; i++) {
            int[] nextDp = new int[3];
            for (int j = 0; j < 3; j++) {
                if (roads[i][j] == 1) {
                    nextDp[j] = Integer.MAX_VALUE;
                } else {
                    nextDp[j] = dp[j];
                    for (int k = 0; k < 3; k++) {
                        if (k != j && roads[i][k] != 1) {
                            nextDp[j] = Math.min(nextDp[j], dp[k] + 1);
                        }
                    }
                }
            }
            dp = nextDp;
        }
        return Math.min(dp[0], Math.min(dp[1], dp[2]));
    }
}
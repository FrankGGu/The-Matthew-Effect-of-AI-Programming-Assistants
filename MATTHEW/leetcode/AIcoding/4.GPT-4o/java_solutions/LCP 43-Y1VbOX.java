public class Solution {
    public boolean canCross(int[] stones) {
        int n = stones.length;
        if (n == 0 || stones[0] != 0) return false;
        boolean[][] dp = new boolean[n][n + 1];
        dp[0][0] = true;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= n; j++) {
                if (dp[i][j]) {
                    for (int k = -1; k <= 1; k++) {
                        int nextJump = j + k;
                        if (nextJump > 0) {
                            int nextPos = stones[i] + nextJump;
                            for (int m = i + 1; m < n; m++) {
                                if (stones[m] == nextPos) {
                                    dp[m][nextJump] = true;
                                    break;
                                } else if (stones[m] > nextPos) {
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }

        for (int j = 0; j <= n; j++) {
            if (dp[n - 1][j]) return true;
        }
        return false;
    }
}
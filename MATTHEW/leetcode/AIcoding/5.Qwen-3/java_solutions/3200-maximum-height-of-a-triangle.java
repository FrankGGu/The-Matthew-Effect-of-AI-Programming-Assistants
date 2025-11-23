public class Solution {
    public int maxHeight(int[] rods) {
        int n = rods.length;
        int total = 0;
        for (int r : rods) total += r;

        boolean[][] dp = new boolean[n + 1][total + 1];
        dp[0][0] = true;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j <= total; j++) {
                if (dp[i][j]) {
                    dp[i + 1][j] = true;
                    if (j + rods[i] <= total) {
                        dp[i + 1][j + rods[i]] = true;
                    }
                }
            }
        }

        for (int h = 0; h <= total / 2; h++) {
            for (int a = 0; a <= total; a++) {
                if (dp[n][a] && a - h >= 0 && dp[n][a - h]) {
                    return h;
                }
            }
        }

        return 0;
    }
}
public class Solution {
    public int findRotateSteps(String ring, String key) {
        int n = ring.length();
        int m = key.length();
        int[][] dp = new int[m][n];

        for (int i = 0; i < n; i++) {
            dp[0][i] = Math.min(Math.abs(i), n - Math.abs(i)) + 1;
        }

        for (int i = 1; i < m; i++) {
            char target = key.charAt(i);
            for (int j = 0; j < n; j++) {
                if (ring.charAt(j) == target) {
                    int minSteps = Integer.MAX_VALUE;
                    for (int k = 0; k < n; k++) {
                        if (ring.charAt(k) == key.charAt(i - 1)) {
                            int steps = Math.min(Math.abs(j - k), n - Math.abs(j - k)) + 1;
                            minSteps = Math.min(minSteps, dp[i - 1][k] + steps);
                        }
                    }
                    dp[i][j] = minSteps;
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            result = Math.min(result, dp[m - 1][i]);
        }
        return result;
    }
}
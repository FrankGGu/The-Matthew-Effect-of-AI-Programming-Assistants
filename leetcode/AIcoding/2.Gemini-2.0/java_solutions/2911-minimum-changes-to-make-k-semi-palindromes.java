import java.util.Arrays;

class Solution {
    public int solve(String s, int k) {
        int n = s.length();
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE / 2);
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= Math.min(i, k); j++) {
                for (int l = 1; l <= i; l++) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - l][j - 1] + cost(s.substring(i - l, i)));
                }
            }
        }

        return dp[n][k];
    }

    private int cost(String s) {
        int n = s.length();
        int changes = 0;
        for (int i = 0; i < n / 2; i++) {
            if (s.charAt(i) != s.charAt(n - 1 - i)) {
                changes++;
            }
        }
        return changes;
    }

    public int minimumChanges(String s, int k) {
        return solve(s, k);
    }
}
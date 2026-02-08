public class Solution {
    public int getLengthOfOptimalCompression(String s, int k) {
        int n = s.length();
        int[][] dp = new int[n + 1][k + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }
        dp[0][0] = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= k; j++) {
                int cnt = 0;
                int same = 0;
                int diff = 0;
                for (int l = i; l >= 1; l--) {
                    if (s.charAt(l - 1) == s.charAt(i - 1)) {
                        same++;
                    } else {
                        diff++;
                    }
                    if (diff > j) {
                        break;
                    }
                    if (dp[l - 1][j - diff] != Integer.MAX_VALUE) {
                        int cost = dp[l - 1][j - diff] + 1;
                        if (same >= 100) {
                            cost += 2;
                        } else if (same >= 10) {
                            cost += 1;
                        } else if (same >= 2) {
                            cost += 1;
                        }
                        dp[i][j] = Math.min(dp[i][j], cost);
                    }
                }
            }
        }
        return dp[n][k];
    }
}
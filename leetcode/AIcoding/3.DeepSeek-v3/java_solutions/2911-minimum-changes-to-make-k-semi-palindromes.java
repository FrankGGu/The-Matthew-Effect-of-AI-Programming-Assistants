class Solution {
    public int minimumChanges(String s, int k) {
        int n = s.length();
        int[][] dp = new int[k + 1][n + 1];
        int[][] cost = new int[n][n];

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                cost[i][j] = computeCost(s, i, j);
            }
        }

        for (int i = 1; i <= k; i++) {
            for (int j = 1; j <= n; j++) {
                if (i == 1) {
                    dp[i][j] = cost[0][j - 1];
                } else {
                    dp[i][j] = Integer.MAX_VALUE;
                    for (int l = i - 1; l < j; l++) {
                        dp[i][j] = Math.min(dp[i][j], dp[i - 1][l] + cost[l][j - 1]);
                    }
                }
            }
        }

        return dp[k][n];
    }

    private int computeCost(String s, int left, int right) {
        int len = right - left + 1;
        int minCost = Integer.MAX_VALUE;
        for (int d = 1; d < len; d++) {
            if (len % d != 0) continue;
            int cost = 0;
            for (int i = 0; i < d; i++) {
                int start = left + i;
                int end = right - (d - 1 - i);
                while (start < end) {
                    if (s.charAt(start) != s.charAt(end)) {
                        cost++;
                    }
                    start += d;
                    end -= d;
                }
            }
            minCost = Math.min(minCost, cost);
        }
        return minCost;
    }
}
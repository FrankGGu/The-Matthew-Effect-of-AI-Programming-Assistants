class Solution {
    public int maxValue(int[][] events, int k) {
        int n = events.length;
        Arrays.sort(events, (a, b) -> a[0] - b[0]);
        int[][] dp = new int[k + 1][n + 1];

        for (int j = 1; j <= k; j++) {
            for (int i = 1; i <= n; i++) {
                dp[j][i] = Math.max(dp[j][i - 1], events[i - 1][2]);
                for (int l = i - 1; l >= 1; l--) {
                    if (events[l - 1][1] < events[i - 1][0]) {
                        dp[j][i] = Math.max(dp[j][i], dp[j - 1][l] + events[i - 1][2]);
                        break;
                    }
                }
            }
        }

        return dp[k][n];
    }
}
class Solution {
    public int minimumWhiteTiles(String floor, int numCarpets, int carpetLen) {
        int n = floor.length();
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + (floor.charAt(i) - '0');
        }

        int[][] dp = new int[numCarpets + 1][n + 1];

        for (int i = 1; i <= numCarpets; i++) {
            for (int j = 1; j <= n; j++) {
                dp[i][j] = Math.min(dp[i - 1][Math.max(0, j - carpetLen)], dp[i][j - 1] + (floor.charAt(j - 1) - '0'));
            }
        }

        return dp[numCarpets][n];
    }
}
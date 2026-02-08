class Solution {
    public int minimumWhiteTiles(String floor, int numCarpets, int carpetLen) {
        int n = floor.length();
        int[][] dp = new int[n + 1][numCarpets + 1];

        for (int i = 1; i <= n; i++) {
            for (int k = 0; k <= numCarpets; k++) {
                int skip = dp[i - 1][k] + (floor.charAt(i - 1) == '1' ? 1 : 0);
                if (k == 0) {
                    dp[i][k] = skip;
                } else {
                    int cover = dp[Math.max(0, i - carpetLen)][k - 1];
                    dp[i][k] = Math.min(skip, cover);
                }
            }
        }

        return dp[n][numCarpets];
    }
}
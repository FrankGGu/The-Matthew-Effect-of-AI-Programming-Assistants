class Solution {
    public int superEggDrop(int K, int N) {
        int[][] dp = new int[K + 1][N + 1];

        for (int m = 1; m <= N; m++) {
            for (int k = 1; k <= K; k++) {
                dp[k][m] = 1 + dp[k - 1][m - 1] + dp[k][m - 1];
                if (k == K && dp[K][m] >= N) {
                    return m;
                }
            }
        }
        return N;
    }
}
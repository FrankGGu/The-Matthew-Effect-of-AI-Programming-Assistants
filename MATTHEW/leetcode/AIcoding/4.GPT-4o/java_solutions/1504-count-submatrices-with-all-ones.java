class Solution {
    public int numSubmat(int[][] mat) {
        int rows = mat.length;
        int cols = mat[0].length;
        int[][] dp = new int[rows][cols];
        int count = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (mat[i][j] == 1) {
                    dp[i][j] = (j == 0 ? 1 : dp[i][j - 1] + 1);
                    int minWidth = dp[i][j];
                    for (int k = i; k >= 0; k--) {
                        if (mat[k][j] == 0) break;
                        minWidth = Math.min(minWidth, dp[k][j]);
                        count += minWidth;
                    }
                }
            }
        }
        return count;
    }
}
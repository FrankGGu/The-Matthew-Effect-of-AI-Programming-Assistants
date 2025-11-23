public class Solution {
    private int[][] dp;
    private int[][] matrix;
    private int m;
    private int n;

    public int longestIncreasingPath(int[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return 0;
        }
        m = matrix.length;
        n = matrix[0].length;
        dp = new int[m][n];
        this.matrix = matrix;
        int max = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                max = Math.max(max, dfs(i, j));
            }
        }
        return max;
    }

    private int dfs(int i, int j) {
        if (dp[i][j] != 0) {
            return dp[i][j];
        }
        int maxPath = 1;
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        for (int[] dir : directions) {
            int x = i + dir[0];
            int y = j + dir[1];
            if (x >= 0 && x < m && y >= 0 && y < n && matrix[x][y] > matrix[i][j]) {
                maxPath = Math.max(maxPath, 1 + dfs(x, y));
            }
        }
        dp[i][j] = maxPath;
        return maxPath;
    }
}
class Solution {
    public int extractMantra(String[] matrix, String mantra) {
        int m = matrix.length;
        int n = matrix[0].length();
        int len = mantra.length();
        int[][][] dp = new int[m][n][len + 1];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                Arrays.fill(dp[i][j], Integer.MAX_VALUE);
            }
        }

        Queue<int[]> queue = new LinkedList<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (matrix[i].charAt(j) == mantra.charAt(0)) {
                    dp[i][j][1] = 0;
                    queue.offer(new int[]{i, j, 1});
                }
            }
        }

        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int x = curr[0], y = curr[1], k = curr[2];
            if (k == len) {
                return dp[x][y][k] + len;
            }

            for (int[] dir : dirs) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    if (dp[nx][ny][k] > dp[x][y][k] + 1) {
                        dp[nx][ny][k] = dp[x][y][k] + 1;
                        queue.offer(new int[]{nx, ny, k});
                    }
                }
            }

            if (matrix[x].charAt(y) == mantra.charAt(k)) {
                if (dp[x][y][k + 1] > dp[x][y][k]) {
                    dp[x][y][k + 1] = dp[x][y][k];
                    queue.offer(new int[]{x, y, k + 1});
                }
            }
        }

        return -1;
    }
}
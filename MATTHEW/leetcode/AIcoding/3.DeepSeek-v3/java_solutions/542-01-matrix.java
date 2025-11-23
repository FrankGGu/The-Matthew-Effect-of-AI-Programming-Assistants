class Solution {
    public int[][] updateMatrix(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;
        int[][] dist = new int[m][n];
        Queue<int[]> queue = new LinkedList<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (mat[i][j] == 0) {
                    dist[i][j] = 0;
                    queue.offer(new int[]{i, j});
                } else {
                    dist[i][j] = Integer.MAX_VALUE;
                }
            }
        }

        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        while (!queue.isEmpty()) {
            int[] cell = queue.poll();
            for (int[] dir : dirs) {
                int r = cell[0] + dir[0];
                int c = cell[1] + dir[1];
                if (r >= 0 && r < m && c >= 0 && c < n) {
                    if (dist[r][c] > dist[cell[0]][cell[1]] + 1) {
                        dist[r][c] = dist[cell[0]][cell[1]] + 1;
                        queue.offer(new int[]{r, c});
                    }
                }
            }
        }

        return dist;
    }
}
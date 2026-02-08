class Solution {
    private static final int[][] DIRS = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int guardCastle(String[] grid) {
        int m = grid.length;
        int n = grid[0].length();
        char[][] g = new char[m][n];
        for (int i = 0; i < m; i++) {
            g[i] = grid[i].toCharArray();
        }
        int[] portal = null;
        int[] demon = null;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (g[i][j] == 'P') {
                    portal = new int[]{i, j};
                } else if (g[i][j] == 'S') {
                    demon = new int[]{i, j};
                }
            }
        }
        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }
        Queue<int[]> q = new LinkedList<>();
        q.offer(demon);
        dist[demon[0]][demon[1]] = 0;
        while (!q.isEmpty()) {
            int[] cur = q.poll();
            for (int[] dir : DIRS) {
                int x = cur[0] + dir[0];
                int y = cur[1] + dir[1];
                if (x >= 0 && x < m && y >= 0 && y < n && g[x][y] != '#' && dist[x][y] == Integer.MAX_VALUE) {
                    dist[x][y] = dist[cur[0]][cur[1]] + 1;
                    q.offer(new int[]{x, y});
                }
            }
        }
        int res = dist[portal[0]][portal[1]];
        return res == Integer.MAX_VALUE ? -1 : res;
    }
}
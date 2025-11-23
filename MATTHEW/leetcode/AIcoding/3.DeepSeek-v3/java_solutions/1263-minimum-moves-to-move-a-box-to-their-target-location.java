class Solution {
    private static final int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int minPushBox(char[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[] box = null, target = null, player = null;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 'B') box = new int[]{i, j};
                else if (grid[i][j] == 'T') target = new int[]{i, j};
                else if (grid[i][j] == 'S') player = new int[]{i, j};
            }
        }
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{box[0], box[1], player[0], player[1]});
        boolean[][][][] visited = new boolean[m][n][m][n];
        visited[box[0]][box[1]][player[0]][player[1]] = true;
        int steps = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            while (size-- > 0) {
                int[] current = queue.poll();
                int bx = current[0], by = current[1];
                int px = current[2], py = current[3];
                if (bx == target[0] && by == target[1]) return steps;
                for (int[] dir : dirs) {
                    int nbx = bx + dir[0], nby = by + dir[1];
                    int npx = bx - dir[0], npy = by - dir[1];
                    if (nbx < 0 || nbx >= m || nby < 0 || nby >= n || grid[nbx][nby] == '#') continue;
                    if (npx < 0 || npx >= m || npy < 0 || npy >= n || grid[npx][npy] == '#') continue;
                    if (visited[nbx][nby][bx][by]) continue;
                    if (canReach(grid, px, py, npx, npy, bx, by)) {
                        visited[nbx][nby][bx][by] = true;
                        queue.offer(new int[]{nbx, nby, bx, by});
                    }
                }
            }
            steps++;
        }
        return -1;
    }

    private boolean canReach(char[][] grid, int x, int y, int tx, int ty, int bx, int by) {
        if (x == tx && y == ty) return true;
        int m = grid.length, n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{x, y});
        visited[x][y] = true;
        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            for (int[] dir : dirs) {
                int nx = current[0] + dir[0], ny = current[1] + dir[1];
                if (nx < 0 || nx >= m || ny < 0 || ny >= n || grid[nx][ny] == '#' || (nx == bx && ny == by) || visited[nx][ny]) continue;
                if (nx == tx && ny == ty) return true;
                visited[nx][ny] = true;
                queue.offer(new int[]{nx, ny});
            }
        }
        return false;
    }
}
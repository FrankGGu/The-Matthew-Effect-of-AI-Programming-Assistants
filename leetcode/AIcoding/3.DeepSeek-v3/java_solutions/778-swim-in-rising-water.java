class Solution {
    private int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int swimInWater(int[][] grid) {
        int n = grid.length;
        int left = 0, right = n * n - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canReach(grid, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private boolean canReach(int[][] grid, int t) {
        int n = grid.length;
        boolean[][] visited = new boolean[n][n];
        Queue<int[]> queue = new LinkedList<>();
        if (grid[0][0] <= t) {
            queue.offer(new int[]{0, 0});
            visited[0][0] = true;
        }
        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int i = curr[0], j = curr[1];
            if (i == n - 1 && j == n - 1) {
                return true;
            }
            for (int[] dir : dirs) {
                int x = i + dir[0], y = j + dir[1];
                if (x >= 0 && x < n && y >= 0 && y < n && !visited[x][y] && grid[x][y] <= t) {
                    visited[x][y] = true;
                    queue.offer(new int[]{x, y});
                }
            }
        }
        return false;
    }
}
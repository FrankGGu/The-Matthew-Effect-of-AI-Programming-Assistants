class Solution {
    public int maxDistance(int[][] grid) {
        int n = grid.length;
        int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[n][n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    queue.offer(new int[] {i, j});
                    visited[i][j] = true;
                }
            }
        }

        if (queue.isEmpty() || queue.size() == n * n) return -1;

        int distance = -1;
        while (!queue.isEmpty()) {
            int size = queue.size();
            distance++;
            for (int i = 0; i < size; i++) {
                int[] cell = queue.poll();
                for (int[] dir : directions) {
                    int newX = cell[0] + dir[0];
                    int newY = cell[1] + dir[1];
                    if (newX >= 0 && newX < n && newY >= 0 && newY < n && !visited[newX][newY] && grid[newX][newY] == 0) {
                        visited[newX][newY] = true;
                        queue.offer(new int[] {newX, newY});
                    }
                }
            }
        }

        return distance;
    }
}
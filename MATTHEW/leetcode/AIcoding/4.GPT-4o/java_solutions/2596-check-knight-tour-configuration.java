public class Solution {
    public boolean checkValidGrid(int[][] grid) {
        int n = grid.length;
        if (n == 0 || n != grid[0].length) return false;
        int[] dx = {2, 1, -1, -2, -2, -1, 1, 2};
        int[] dy = {1, 2, 2, 1, -1, -2, -2, -1};
        boolean[] visited = new boolean[n * n];
        int startX = 0, startY = 0;
        visited[0] = true;

        for (int i = 1; i < n * n; i++) {
            int x = -1, y = -1;
            for (int j = 0; j < n * n; j++) {
                if (grid[j / n][j % n] == i) {
                    x = j / n;
                    y = j % n;
                    break;
                }
            }
            if (x == -1 || y == -1) return false;
            if (!isValid(startX, startY, x, y, dx, dy)) return false;
            visited[i] = true;
            startX = x;
            startY = y;
        }
        return true;
    }

    private boolean isValid(int x1, int y1, int x2, int y2, int[] dx, int[] dy) {
        for (int i = 0; i < 8; i++) {
            if (x1 + dx[i] == x2 && y1 + dy[i] == y2) {
                return true;
            }
        }
        return false;
    }
}
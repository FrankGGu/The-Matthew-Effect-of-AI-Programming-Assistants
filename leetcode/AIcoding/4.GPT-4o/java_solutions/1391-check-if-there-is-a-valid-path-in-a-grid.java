import java.util.LinkedList;
import java.util.Queue;

public class Solution {
    public boolean hasValidPath(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[] {0, 0});
        visited[0][0] = true;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int x = curr[0], y = curr[1];
            if (x == m - 1 && y == n - 1) return true;

            for (int[] dir : getDirections(grid[x][y])) {
                int newX = x + dir[0], newY = y + dir[1];
                if (newX >= 0 && newX < m && newY >= 0 && newY < n && !visited[newX][newY] && canMove(grid[x][y], grid[newX][newY], dir[0], dir[1])) {
                    visited[newX][newY] = true;
                    queue.offer(new int[] {newX, newY});
                }
            }
        }

        return false;
    }

    private int[][] getDirections(int type) {
        switch (type) {
            case 1: return new int[][] {{0, 1}, {0, -1}};
            case 2: return new int[][] {{1, 0}, {-1, 0}};
            case 3: return new int[][] {{0, 1}, {1, 0}};
            case 4: return new int[][] {{0, -1}, {1, 0}};
            case 5: return new int[][] {{0, 1}, {-1, 0}};
            case 6: return new int[][] {{0, -1}, {-1, 0}};
            default: return new int[0][];
        }
    }

    private boolean canMove(int fromType, int toType, int dx, int dy) {
        if (dx == 0) {
            return (fromType == 1 || fromType == 3 || fromType == 4) && (toType == 1 || toType == 3 || toType == 6);
        } else {
            return (fromType == 2 || fromType == 3 || fromType == 5) && (toType == 2 || toType == 3 || toType == 4);
        }
    }
}
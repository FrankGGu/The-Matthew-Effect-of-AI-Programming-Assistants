import java.util.*;

public class Solution {
    public boolean canEscape(int[][] maze, int[] start, int[] destination) {
        int rows = maze.length, cols = maze[0].length;
        boolean[][] visited = new boolean[rows][cols];
        return dfs(maze, start[0], start[1], destination[0], destination[1], visited);
    }

    private boolean dfs(int[][] maze, int x, int y, int destX, int destY, boolean[][] visited) {
        if (x == destX && y == destY) {
            return true;
        }
        if (visited[x][y]) {
            return false;
        }
        visited[x][y] = true;

        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        for (int[] dir : directions) {
            int newX = x, newY = y;
            while (newX + dir[0] >= 0 && newX + dir[0] < maze.length && newY + dir[1] >= 0 && newY + dir[1] < maze[0].length && maze[newX + dir[0]][newY + dir[1]] == 0) {
                newX += dir[0];
                newY += dir[1];
            }
            if (dfs(maze, newX, newY, destX, destY, visited)) {
                return true;
            }
        }
        return false;
    }
}
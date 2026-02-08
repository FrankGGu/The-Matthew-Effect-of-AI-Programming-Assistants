public class Solution {

import java.util.*;

public class Solution {
    public int cutOffTree(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        List<int[]> trees = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] > 0) {
                    trees.add(new int[]{i, j});
                }
            }
        }
        Collections.sort(trees, (a, b) -> grid[a[0]][a[1]] - grid[b[0]][b[1]]);
        int totalSteps = 0;
        int[] start = {0, 0};
        for (int[] tree : trees) {
            int steps = bfs(grid, start, tree);
            if (steps == -1) {
                return -1;
            }
            totalSteps += steps;
            start = tree;
        }
        return totalSteps;
    }

    private int bfs(int[][] grid, int[] start, int[] end) {
        int m = grid.length;
        int n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        Queue<int[]> queue = new LinkedList<>();
        queue.add(new int[]{start[0], start[1], 0});
        visited[start[0]][start[1]] = true;
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int x = current[0];
            int y = current[1];
            int steps = current[2];
            if (x == end[0] && y == end[1]) {
                return steps;
            }
            for (int[] dir : directions) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && grid[nx][ny] > 0) {
                    visited[nx][ny] = true;
                    queue.add(new int[]{nx, ny, steps + 1});
                }
            }
        }
        return -1;
    }
}
}
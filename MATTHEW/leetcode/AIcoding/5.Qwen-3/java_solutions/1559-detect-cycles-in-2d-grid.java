public class Solution {

import java.util.*;

public class Solution {
    public boolean containsCycle(char[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        boolean[][] visited = new boolean[rows][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (!visited[i][j]) {
                    if (bfs(grid, i, j, visited)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private boolean bfs(char[][] grid, int startRow, int startCol, boolean[][] visited) {
        int rows = grid.length;
        int cols = grid[0].length;
        Queue<int[]> queue = new LinkedList<>();
        Map<String, int[]> parent = new HashMap<>();
        char startChar = grid[startRow][startCol];
        queue.offer(new int[]{startRow, startCol});
        visited[startRow][startCol] = true;

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int row = current[0];
            int col = current[1];

            for (int[] dir : new int[][]{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}) {
                int newRow = row + dir[0];
                int newCol = col + dir[1];

                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] == startChar) {
                    if (visited[newRow][newCol]) {
                        String key = newRow + "," + newCol;
                        if (parent.containsKey(key)) {
                            int[] prev = parent.get(key);
                            if (prev[0] != row || prev[1] != col) {
                                return true;
                            }
                        }
                    } else {
                        visited[newRow][newCol] = true;
                        parent.put(newRow + "," + newCol, new int[]{row, col});
                        queue.offer(new int[]{newRow, newCol});
                    }
                }
            }
        }
        return false;
    }
}
}
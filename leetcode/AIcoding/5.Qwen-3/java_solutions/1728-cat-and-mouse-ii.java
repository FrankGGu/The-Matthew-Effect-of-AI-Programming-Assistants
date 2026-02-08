public class Solution {

import java.util.*;

public class Solution {
    public int catMouseGame(int[][] grid, int catJump, int mouseJump) {
        int m = grid.length;
        int n = grid[0].length;
        int[][][] dp = new int[m][n][2 * m * n];
        int[][][] visited = new int[m][n][2 * m * n];
        Queue<int[]> queue = new LinkedList<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    for (int k = 0; k < 2 * m * n; k++) {
                        dp[i][j][k] = 2;
                        visited[i][j][k] = 1;
                        queue.offer(new int[]{i, j, k});
                    }
                }
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 2) {
                    for (int k = 0; k < 2 * m * n; k++) {
                        dp[i][j][k] = 1;
                        visited[i][j][k] = 1;
                        queue.offer(new int[]{i, j, k});
                    }
                }
            }
        }

        while (!queue.isEmpty()) {
            int[] state = queue.poll();
            int mouseRow = state[0], mouseCol = state[1], turn = state[2];
            int currentResult = dp[mouseRow][mouseCol][turn];

            if (turn % 2 == 0) {
                for (int[] dir : getDirections(mouseRow, mouseCol, grid, mouseJump)) {
                    int nextMouseRow = dir[0], nextMouseCol = dir[1];
                    int nextTurn = turn + 1;
                    if (dp[nextMouseRow][nextMouseCol][nextTurn] == 0 && visited[nextMouseRow][nextMouseCol][nextTurn] == 0) {
                        if (currentResult == 1) {
                            dp[nextMouseRow][nextMouseCol][nextTurn] = 1;
                            visited[nextMouseRow][nextMouseCol][nextTurn] = 1;
                            queue.offer(new int[]{nextMouseRow, nextMouseCol, nextTurn});
                        } else if (currentResult == 2) {
                            dp[nextMouseRow][nextMouseCol][nextTurn] = 2;
                            visited[nextMouseRow][nextMouseCol][nextTurn] = 1;
                            queue.offer(new int[]{nextMouseRow, nextMouseCol, nextTurn});
                        }
                    }
                }
            } else {
                for (int[] dir : getDirections(mouseRow, mouseCol, grid, catJump)) {
                    int nextCatRow = dir[0], nextCatCol = dir[1];
                    int nextTurn = turn + 1;
                    if (dp[nextCatRow][nextCatCol][nextTurn] == 0 && visited[nextCatRow][nextCatCol][nextTurn] == 0) {
                        if (currentResult == 1) {
                            dp[nextCatRow][nextCatCol][nextTurn] = 1;
                            visited[nextCatRow][nextCatCol][nextTurn] = 1;
                            queue.offer(new int[]{nextCatRow, nextCatCol, nextTurn});
                        } else if (currentResult == 2) {
                            dp[nextCatRow][nextCatCol][nextTurn] = 2;
                            visited[nextCatRow][nextCatCol][nextTurn] = 1;
                            queue.offer(new int[]{nextCatRow, nextCatCol, nextTurn});
                        }
                    }
                }
            }
        }

        return dp[0][0][0];
    }

    private List<int[]> getDirections(int row, int col, int[][] grid, int jump) {
        List<int[]> directions = new ArrayList<>();
        int m = grid.length;
        int n = grid[0].length;

        for (int dr = -1; dr <= 1; dr++) {
            for (int dc = -1; dc <= 1; dc++) {
                if (dr == 0 && dc == 0) continue;
                for (int step = 1; step <= jump; step++) {
                    int newRow = row + dr * step;
                    int newCol = col + dc * step;
                    if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && grid[newRow][newCol] != 0) {
                        directions.add(new int[]{newRow, newCol});
                    } else {
                        break;
                    }
                }
            }
        }

        return directions;
    }
}
}
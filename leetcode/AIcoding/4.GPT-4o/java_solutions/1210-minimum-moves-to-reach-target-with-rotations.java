import java.util.LinkedList;
import java.util.Queue;

public class Solution {
    public int minimumMoves(int[][] grid) {
        int n = grid.length;
        boolean[][][] visited = new boolean[n][n][2];
        Queue<State> queue = new LinkedList<>();
        queue.offer(new State(0, 1, 0));
        visited[0][1][0] = true;
        int moves = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                State curr = queue.poll();
                if (curr.row == n - 1 && curr.col == n - 1 && curr.orientation == 0) {
                    return moves;
                }

                if (curr.orientation == 0) {
                    if (curr.col + 1 < n && grid[curr.row][curr.col + 1] == 0 && grid[curr.row][curr.col] == 0) {
                        if (!visited[curr.row][curr.col + 1][0]) {
                            visited[curr.row][curr.col + 1][0] = true;
                            queue.offer(new State(curr.row, curr.col + 1, 0));
                        }
                    }
                    if (curr.row + 1 < n && grid[curr.row + 1][curr.col] == 0) {
                        if (!visited[curr.row + 1][curr.col][1]) {
                            visited[curr.row + 1][curr.col][1] = true;
                            queue.offer(new State(curr.row + 1, curr.col, 1));
                        }
                    }
                } else {
                    if (curr.row + 1 < n && grid[curr.row + 1][curr.col] == 0 && grid[curr.row][curr.col] == 0) {
                        if (!visited[curr.row + 1][curr.col][1]) {
                            visited[curr.row + 1][curr.col][1] = true;
                            queue.offer(new State(curr.row + 1, curr.col, 1));
                        }
                    }
                    if (curr.col + 1 < n && grid[curr.row][curr.col + 1] == 0) {
                        if (!visited[curr.row][curr.col + 1][0]) {
                            visited[curr.row][curr.col + 1][0] = true;
                            queue.offer(new State(curr.row, curr.col + 1, 0));
                        }
                    }
                }
            }
            moves++;
        }
        return -1;
    }

    private static class State {
        int row, col, orientation;
        State(int row, int col, int orientation) {
            this.row = row;
            this.col = col;
            this.orientation = orientation;
        }
    }
}
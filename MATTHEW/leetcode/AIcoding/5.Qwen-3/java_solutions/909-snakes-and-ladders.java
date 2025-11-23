public class Solution {

import java.util.*;

public class Solution {
    public int snakesAndLadders(int[][] board) {
        int n = board.length;
        int target = n * n;
        boolean[] visited = new boolean[target + 1];
        Queue<int[]> queue = new LinkedList<>();
        queue.add(new int[]{1, 0});
        visited[1] = true;

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int position = current[0];
            int steps = current[1];

            if (position == target) {
                return steps;
            }

            for (int i = 1; i <= 6; i++) {
                int nextPosition = position + i;
                if (nextPosition > target) {
                    break;
                }

                int[] rowCol = getRowCol(n, nextPosition);
                int row = rowCol[0];
                int col = rowCol[1];

                if (board[row][col] != -1) {
                    nextPosition = board[row][col];
                }

                if (!visited[nextPosition]) {
                    visited[nextPosition] = true;
                    queue.add(new int[]{nextPosition, steps + 1});
                }
            }
        }

        return -1;
    }

    private int[] getRowCol(int n, int position) {
        int[] result = new int[2];
        int row = n - 1 - (position - 1) / n;
        int col = (position - 1) % n;
        if ((n - row) % 2 == 0) {
            col = n - 1 - col;
        }
        result[0] = row;
        result[1] = col;
        return result;
    }
}
}
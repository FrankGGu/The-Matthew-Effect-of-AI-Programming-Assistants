import java.util.LinkedList;
import java.util.Queue;

public class Solution {
    public int snakesAndLadders(int[][] board) {
        int n = board.length;
        boolean[] visited = new boolean[n * n];
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(1);
        visited[0] = true;
        int moves = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int current = queue.poll();
                if (current == n * n) return moves;

                for (int j = 1; j <= 6; j++) {
                    int next = current + j;
                    if (next > n * n) continue;

                    int[] coordinates = getCoordinates(next, n);
                    int row = coordinates[0], col = coordinates[1];

                    if (board[row][col] != -1) {
                        next = board[row][col];
                    }

                    if (!visited[next - 1]) {
                        visited[next - 1] = true;
                        queue.offer(next);
                    }
                }
            }
            moves++;
        }
        return -1;
    }

    private int[] getCoordinates(int num, int n) {
        int row = (num - 1) / n;
        int col = (num - 1) % n;
        if (row % 2 == 1) {
            col = n - 1 - col;
        }
        return new int[]{n - 1 - row, col};
    }
}
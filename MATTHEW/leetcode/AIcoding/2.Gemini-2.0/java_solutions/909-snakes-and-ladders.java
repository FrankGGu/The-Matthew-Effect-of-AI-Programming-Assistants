import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int snakesAndLadders(int[][] board) {
        int n = board.length;
        boolean[] visited = new boolean[n * n + 1];
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(1);
        visited[1] = true;
        int moves = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int curr = queue.poll();
                if (curr == n * n) {
                    return moves;
                }

                for (int next = curr + 1; next <= Math.min(curr + 6, n * n); next++) {
                    int row = (next - 1) / n;
                    int col = (next - 1) % n;
                    int r = n - 1 - row;
                    int c = (row % 2 == 0) ? col : n - 1 - col;

                    int destination = (board[r][c] != -1) ? board[r][c] : next;

                    if (!visited[destination]) {
                        visited[destination] = true;
                        queue.offer(destination);
                    }
                }
            }
            moves++;
        }

        return -1;
    }
}
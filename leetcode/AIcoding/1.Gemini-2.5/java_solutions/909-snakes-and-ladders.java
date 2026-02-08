import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int snakesAndLadders(int[][] board) {
        int n = board.length;
        int targetSquare = n * n;

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{1, 0}); // {square_number, moves}

        boolean[] visited = new boolean[targetSquare + 1];
        visited[1] = true;

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int currentSquare = current[0];
            int moves = current[1];

            if (currentSquare == targetSquare) {
                return moves;
            }

            for (int i = 1; i <= 6; i++) {
                int nextSquareCandidate = currentSquare + i;

                if (nextSquareCandidate > targetSquare) {
                    continue;
                }

                int[] coords = getCoordinates(nextSquareCandidate, n);
                int r = coords[0];
                int c = coords[1];

                int actualNextSquare = nextSquareCandidate;
                if (board[r][c] != -1) {
                    actualNextSquare = board[r][c];
                }

                if (!visited[actualNextSquare]) {
                    visited[actualNextSquare] = true;
                    queue.offer(new int[]{actualNextSquare, moves + 1});
                }
            }
        }

        return -1;
    }

    private int[] getCoordinates(int squareNum, int n) {
        int r_from_bottom = (squareNum - 1) / n;
        int row = n - 1 - r_from_bottom;

        int col;
        if (r_from_bottom % 2 == 0) {
            col = (squareNum - 1) % n;
        } else {
            col = n - 1 - ((squareNum - 1) % n);
        }
        return new int[]{row, col};
    }
}
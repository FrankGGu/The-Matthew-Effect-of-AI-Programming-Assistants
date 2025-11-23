import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> queensAttacktheKing(int[][] queens, int[] king) {
        boolean[][] board = new boolean[8][8];
        for (int[] queen : queens) {
            board[queen[0]][queen[1]] = true;
        }

        List<List<Integer>> attackingQueens = new ArrayList<>();
        int kingX = king[0];
        int kingY = king[1];

        // Define all 8 directions: horizontal, vertical, and diagonal
        int[] dx = {-1, -1, -1, 0, 0, 1, 1, 1};
        int[] dy = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int i = 0; i < 8; i++) {
            int currentX = kingX;
            int currentY = kingY;

            while (true) {
                currentX += dx[i];
                currentY += dy[i];

                // Check if out of bounds
                if (currentX < 0 || currentX >= 8 || currentY < 0 || currentY >= 8) {
                    break;
                }

                // Check if there's a queen at the current position
                if (board[currentX][currentY]) {
                    List<Integer> queenPos = new ArrayList<>();
                    queenPos.add(currentX);
                    queenPos.add(currentY);
                    attackingQueens.add(queenPos);
                    break; // Found the closest queen in this direction, move to next direction
                }
            }
        }

        return attackingQueens;
    }
}
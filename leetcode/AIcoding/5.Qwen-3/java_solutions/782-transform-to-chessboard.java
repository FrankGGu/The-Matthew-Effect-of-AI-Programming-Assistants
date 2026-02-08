public class Solution {
    public int movesToChessboard(int[][] board) {
        int n = board.length;
        int rowMoves = 0, colMoves = 0;

        for (int i = 0; i < n; i++) {
            if (board[0][i] != i % 2) rowMoves++;
            if (board[i][0] != i % 2) colMoves++;
        }

        if (n % 2 == 0) {
            if (rowMoves % 2 != 0 || colMoves % 2 != 0) return -1;
            return rowMoves / 2 + colMoves / 2;
        } else {
            if (rowMoves % 2 != 0 && colMoves % 2 != 0) return rowMoves / 2 + colMoves / 2;
            if (rowMoves % 2 == 0 && colMoves % 2 == 0) return rowMoves / 2 + colMoves / 2;
            return -1;
        }
    }
}
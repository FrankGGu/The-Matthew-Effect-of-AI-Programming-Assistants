public class Solution {
    public String tictactoe(int[] moves) {
        int[][] board = new int[3][3];
        for (int i = 0; i < moves.length; i++) {
            int row = moves[i] / 3;
            int col = moves[i] % 3;
            int player = i % 2 + 1;
            board[row][col] = player;
            if (checkWin(board, row, col, player)) {
                return player == 1 ? "A" : "B";
            }
        }
        return moves.length == 9 ? "Draw" : "Pending";
    }

    private boolean checkWin(int[][] board, int row, int col, int player) {
        boolean rowWin = true;
        for (int j = 0; j < 3; j++) {
            if (board[row][j] != player) {
                rowWin = false;
                break;
            }
        }
        if (rowWin) return true;

        boolean colWin = true;
        for (int i = 0; i < 3; i++) {
            if (board[i][col] != player) {
                colWin = false;
                break;
            }
        }
        if (colWin) return true;

        if (row == col) {
            boolean diag1Win = true;
            for (int i = 0; i < 3; i++) {
                if (board[i][i] != player) {
                    diag1Win = false;
                    break;
                }
            }
            if (diag1Win) return true;
        }

        if (row + col == 2) {
            boolean diag2Win = true;
            for (int i = 0; i < 3; i++) {
                if (board[i][2 - i] != player) {
                    diag2Win = false;
                    break;
                }
            }
            if (diag2Win) return true;
        }

        return false;
    }
}
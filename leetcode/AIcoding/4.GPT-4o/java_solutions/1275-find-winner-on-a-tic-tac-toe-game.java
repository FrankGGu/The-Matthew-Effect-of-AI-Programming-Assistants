class Solution {
    public String tictactoe(int[][] moves) {
        char[][] board = new char[3][3];

        for (int i = 0; i < moves.length; i++) {
            board[moves[i][0]][moves[i][1]] = (i % 2 == 0) ? 'A' : 'B';
        }

        for (int i = 0; i < 3; i++) {
            if (board[i][0] != 0 && board[i][0] == board[i][1] && board[i][1] == board[i][2]) {
                return String.valueOf(board[i][0]);
            }
            if (board[0][i] != 0 && board[0][i] == board[1][i] && board[1][i] == board[2][i]) {
                return String.valueOf(board[0][i]);
            }
        }

        if (board[0][0] != 0 && board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
            return String.valueOf(board[0][0]);
        }
        if (board[0][2] != 0 && board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
            return String.valueOf(board[0][2]);
        }

        return moves.length == 9 ? "Draw" : "Pending";
    }
}
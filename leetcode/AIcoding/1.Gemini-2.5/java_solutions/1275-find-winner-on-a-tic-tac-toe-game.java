class Solution {
    public String tictactoe(int[][] moves) {
        char[][] board = new char[3][3];

        for (int i = 0; i < moves.length; i++) {
            int r = moves[i][0];
            int c = moves[i][1];
            char playerChar = (i % 2 == 0) ? 'X' : 'O';
            board[r][c] = playerChar;

            if (i >= 4) { 
                if (checkWin(board, playerChar)) {
                    return (playerChar == 'X') ? "A" : "B";
                }
            }
        }

        if (moves.length == 9) {
            return "Draw";
        } else {
            return "Pending";
        }
    }

    private boolean checkWin(char[][] board, char player) {
        for (int i = 0; i < 3; i++) {
            if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
                return true;
            }
        }

        for (int j = 0; j < 3; j++) {
            if (board[0][j] == player && board[1][j] == player && board[2][j] == player) {
                return true;
            }
        }

        if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
            return true;
        }
        if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
            return true;
        }

        return false;
    }
}
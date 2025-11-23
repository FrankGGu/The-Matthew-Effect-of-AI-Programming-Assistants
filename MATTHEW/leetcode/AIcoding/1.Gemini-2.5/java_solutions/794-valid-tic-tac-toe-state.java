class Solution {
    public boolean isValidTicTacToe(String[] board) {
        int numX = 0;
        int numO = 0;

        for (String row : board) {
            for (char c : row.toCharArray()) {
                if (c == 'X') {
                    numX++;
                } else if (c == 'O') {
                    numO++;
                }
            }
        }

        if (numO > numX || numX > numO + 1) {
            return false;
        }

        boolean xWins = checkWin(board, 'X');
        boolean oWins = checkWin(board, 'O');

        if (xWins && oWins) {
            return false;
        }

        if (xWins) {
            return numX == numO + 1;
        }

        if (oWins) {
            return numX == numO;
        }

        return true;
    }

    private boolean checkWin(String[] board, char player) {
        for (int i = 0; i < 3; i++) {
            if (board[i].charAt(0) == player && board[i].charAt(1) == player && board[i].charAt(2) == player) {
                return true;
            }
            if (board[0].charAt(i) == player && board[1].charAt(i) == player && board[2].charAt(i) == player) {
                return true;
            }
        }

        if (board[0].charAt(0) == player && board[1].charAt(1) == player && board[2].charAt(2) == player) {
            return true;
        }
        if (board[0].charAt(2) == player && board[1].charAt(1) == player && board[2].charAt(0) == player) {
            return true;
        }

        return false;
    }
}
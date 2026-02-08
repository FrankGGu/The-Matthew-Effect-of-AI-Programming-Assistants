public class Solution {

import java.util.*;

public class Solution {
    public boolean validTicTacToe(String[] board) {
        int xCount = 0, oCount = 0;
        for (String row : board) {
            for (char c : row.toCharArray()) {
                if (c == 'X') xCount++;
                else if (c == 'O') oCount++;
            }
        }
        if (oCount > xCount || xCount - oCount > 1) return false;

        boolean xWin = checkWin(board, 'X');
        boolean oWin = checkWin(board, 'O');

        if (xWin && oWin) return false;
        if (xWin && xCount != oCount + 1) return false;
        if (oWin && xCount != oCount) return false;

        return true;
    }

    private boolean checkWin(String[] board, char player) {
        for (int i = 0; i < 3; i++) {
            if (board[i][0] == player && board[i][1] == player && board[i][2] == player) return true;
            if (board[0][i] == player && board[1][i] == player && board[2][i] == player) return true;
        }
        if (board[0][0] == player && board[1][1] == player && board[2][2] == player) return true;
        if (board[0][2] == player && board[1][1] == player && board[2][0] == player) return true;
        return false;
    }
}
}
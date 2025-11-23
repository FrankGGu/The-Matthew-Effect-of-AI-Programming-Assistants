public class Solution {
    public boolean isLegalMove(char[][] board, int x1, int y1, int x2, int y2) {
        if (x1 < 0 || x1 >= board.length || y1 < 0 || y1 >= board[0].length || x2 < 0 || x2 >= board.length || y2 < 0 || y2 >= board[0].length) {
            return false;
        }
        char piece = board[x1][y1];
        if (piece == ' ') {
            return false;
        }
        if (board[x2][y2] != ' ') {
            return false;
        }
        switch (piece) {
            case 'P':
                return x2 == x1 + 1 && y2 == y1;
            case 'R':
                return x1 == x2 || y1 == y2;
            case 'N':
                return (Math.abs(x1 - x2) == 2 && Math.abs(y1 - y2) == 1) || (Math.abs(x1 - x2) == 1 && Math.abs(y1 - y2) == 2);
            case 'B':
                return Math.abs(x1 - x2) == Math.abs(y1 - y2);
            case 'Q':
                return x1 == x2 || y1 == y2 || Math.abs(x1 - x2) == Math.abs(y1 - y2);
            case 'K':
                return Math.abs(x1 - x2) <= 1 && Math.abs(y1 - y2) <= 1;
            default:
                return false;
        }
    }
}
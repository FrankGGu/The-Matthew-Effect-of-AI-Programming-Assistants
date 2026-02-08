class Solution {
    public boolean placeWordInCrossword(char[][] board, String word) {
        int m = board.length, n = board[0].length;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == ' ') {
                    if (canPlaceHorizontally(board, i, j, word) || canPlaceVertically(board, i, j, word)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private boolean canPlaceHorizontally(char[][] board, int row, int col, String word) {
        int len = word.length();
        if (col + len > board[0].length) return false;
        for (int i = 0; i < len; i++) {
            if (board[row][col + i] != ' ' && board[row][col + i] != word.charAt(i)) {
                return false;
            }
        }
        if (col > 0 && board[row][col - 1] != '#') return false;
        if (col + len < board[0].length && board[row][col + len] != '#') return false;
        return true;
    }

    private boolean canPlaceVertically(char[][] board, int row, int col, String word) {
        int len = word.length();
        if (row + len > board.length) return false;
        for (int i = 0; i < len; i++) {
            if (board[row + i][col] != ' ' && board[row + i][col] != word.charAt(i)) {
                return false;
            }
        }
        if (row > 0 && board[row - 1][col] != '#') return false;
        if (row + len < board.length && board[row + len][col] != '#') return false;
        return true;
    }
}
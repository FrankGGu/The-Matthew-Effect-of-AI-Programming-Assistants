class Solution {
    public boolean placeWordInCrossword(char[][] board, String word) {
        int m = board.length, n = board[0].length;
        int len = word.length();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == ' ' || board[i][j] == word.charAt(0)) {
                    if (canPlaceHorizontal(board, i, j, word) || canPlaceVertical(board, i, j, word)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private boolean canPlaceHorizontal(char[][] board, int i, int j, String word) {
        int len = word.length();
        int m = board.length, n = board[0].length;
        if (j + len > n) return false;
        if (j > 0 && board[i][j - 1] != '#') return false;
        if (j + len < n && board[i][j + len] != '#') return false;
        for (int k = 0; k < len; k++) {
            if (board[i][j + k] != ' ' && board[i][j + k] != word.charAt(k)) {
                return false;
            }
        }
        return true;
    }

    private boolean canPlaceVertical(char[][] board, int i, int j, String word) {
        int len = word.length();
        int m = board.length, n = board[0].length;
        if (i + len > m) return false;
        if (i > 0 && board[i - 1][j] != '#') return false;
        if (i + len < m && board[i + len][j] != '#') return false;
        for (int k = 0; k < len; k++) {
            if (board[i + k][j] != ' ' && board[i + k][j] != word.charAt(k)) {
                return false;
            }
        }
        return true;
    }
}
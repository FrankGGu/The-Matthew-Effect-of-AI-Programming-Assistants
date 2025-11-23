class Solution {
    public boolean placeWordInCrossword(char[][] board, String word) {
        int m = board.length;
        int n = board[0].length;
        int wordLen = word.length();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == '#' && isValidHorizontal(board, i, j, word, wordLen)) {
                    return true;
                }
                if (board[i][j] == '#' && isValidVertical(board, i, j, word, wordLen)) {
                    return true;
                }
            }
        }

        return false;
    }

    private boolean isValidHorizontal(char[][] board, int row, int col, String word, int wordLen) {
        int m = board.length;
        int n = board[0].length;

        if (col > 0 && board[row][col - 1] != '#') {
            return false;
        }

        if (col + wordLen > n) {
            return false;
        }

        if (col + wordLen < n && board[row][col + wordLen] != '#') {
            return false;
        }

        for (int i = 0; i < wordLen; i++) {
            if (col + i >= n) {
                return false;
            }

            if (board[row][col + i] != ' ' && board[row][col + i] != word.charAt(i)) {
                return false;
            }
        }

        return true;
    }

    private boolean isValidVertical(char[][] board, int row, int col, String word, int wordLen) {
        int m = board.length;
        int n = board[0].length;

        if (row > 0 && board[row - 1][col] != '#') {
            return false;
        }

        if (row + wordLen > m) {
            return false;
        }

        if (row + wordLen < m && board[row + wordLen][col] != '#') {
            return false;
        }

        for (int i = 0; i < wordLen; i++) {
            if (row + i >= m) {
                return false;
            }

            if (board[row + i][col] != ' ' && board[row + i][col] != word.charAt(i)) {
                return false;
            }
        }

        return true;
    }
}
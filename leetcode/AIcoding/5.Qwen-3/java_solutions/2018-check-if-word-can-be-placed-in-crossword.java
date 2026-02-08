public class Solution {
    public boolean placeWordInCrossword(char[][] board, String word) {
        int n = board.length;
        int m = board[0].length;
        int len = word.length();

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (board[i][j] == ' ' || board[i][j] == word[0]) {
                    if (checkHorizontal(board, word, i, j, len)) return true;
                    if (checkVertical(board, word, i, j, len)) return true;
                }
            }
        }
        return false;
    }

    private boolean checkHorizontal(char[][] board, String word, int row, int col, int len) {
        if (col + len > board[0].length) return false;
        boolean valid = true;
        for (int i = 0; i < len; i++) {
            if (board[row][col + i] != ' ' && board[row][col + i] != word.charAt(i)) {
                valid = false;
                break;
            }
        }
        if (valid) {
            if (col + len == board[0].length || board[row][col + len] == ' ') {
                return true;
            }
        }
        return false;
    }

    private boolean checkVertical(char[][] board, String word, int row, int col, int len) {
        if (row + len > board.length) return false;
        boolean valid = true;
        for (int i = 0; i < len; i++) {
            if (board[row + i][col] != ' ' && board[row + i][col] != word.charAt(i)) {
                valid = false;
                break;
            }
        }
        if (valid) {
            if (row + len == board.length || board[row + len][col] == ' ') {
                return true;
            }
        }
        return false;
    }
}
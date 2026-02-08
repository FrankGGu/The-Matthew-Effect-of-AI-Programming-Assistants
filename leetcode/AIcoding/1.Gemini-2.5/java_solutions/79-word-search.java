class Solution {
    private char[][] board;
    private int rows;
    private int cols;
    private String word;

    public boolean exist(char[][] board, String word) {
        this.board = board;
        this.rows = board.length;
        this.cols = board[0].length;
        this.word = word;

        for (int r = 0; r < this.rows; r++) {
            for (int c = 0; c < this.cols; c++) {
                if (dfs(r, c, 0)) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean dfs(int r, int c, int k) {
        if (k == word.length()) {
            return true;
        }

        if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != word.charAt(k)) {
            return false;
        }

        char originalChar = board[r][c];
        board[r][c] = '#'; 

        boolean found = dfs(r + 1, c, k + 1) ||
                        dfs(r - 1, c, k + 1) ||
                        dfs(r, c + 1, k + 1) ||
                        dfs(r, c - 1, k + 1);

        board[r][c] = originalChar;

        return found;
    }
}
class Solution {
    public boolean isValidSudoku(char[][] board) {
        boolean[] rows = new boolean[9];
        boolean[] cols = new boolean[9];
        boolean[][] boxes = new boolean[3][3];

        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                char num = board[i][j];
                if (num != '.') {
                    int n = num - '1';
                    if (rows[i * 9 + n] || cols[j * 9 + n] || boxes[i / 3][j / 3]) {
                        return false;
                    }
                    rows[i * 9 + n] = true;
                    cols[j * 9 + n] = true;
                    boxes[i / 3][j / 3] = true;
                }
            }
        }
        return true;
    }
}
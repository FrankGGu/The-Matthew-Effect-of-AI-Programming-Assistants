void solveSudoku(char** board, int boardSize, int* boardColSize) {
    void backtrack(int row, int col) {
        if (row == 9) return;
        if (col == 9) {
            backtrack(row + 1, 0);
            return;
        }
        if (board[row][col] != '.') {
            backtrack(row, col + 1);
            return;
        }
        for (char num = '1'; num <= '9'; num++) {
            int r = row / 3 * 3 + col / 3, c = col % 3;
            int valid = 1;
            for (int i = 0; i < 9; i++) {
                if (board[row][i] == num || board[i][col] == num || board[r + i / 3][c + i % 3] == num) {
                    valid = 0;
                    break;
                }
            }
            if (valid) {
                board[row][col] = num;
                backtrack(row, col + 1);
                if (board[row][col] != '.') return;
                board[row][col] = '.';
            }
        }
    }
    backtrack(0, 0);
}
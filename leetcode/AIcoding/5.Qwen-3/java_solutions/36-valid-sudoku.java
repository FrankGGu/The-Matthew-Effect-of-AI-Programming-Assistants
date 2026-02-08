public class Solution {
    public boolean isValidSudoku(char[][] board) {
        boolean[] row = new boolean[9];
        boolean[] col = new boolean[9];
        boolean[] box = new boolean[9];

        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (board[i][j] != '.') {
                    int num = board[i][j] - '1';
                    int boxIndex = (i / 3) * 3 + j / 3;
                    if (row[num] || col[num] || box[num]) {
                        return false;
                    }
                    row[num] = true;
                    col[num] = true;
                    box[num] = true;
                }
            }
            row = new boolean[9];
            col = new boolean[9];
            box = new boolean[9];
        }
        return true;
    }
}
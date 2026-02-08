public class Solution {
    public int countBattleships(char[][] board) {
        if (board == null || board.length == 0) return 0;
        int count = 0;
        int rows = board.length, cols = board[0].length;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (board[i][j] == 'X') {
                    if (i == 0 || board[i - 1][j] == '.') {
                        if (j == 0 || board[i][j - 1] == '.') {
                            count++;
                        }
                    }
                }
            }
        }
        return count;
    }
}
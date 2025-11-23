public class Solution {
    public int numRookMoves(char[][] board) {
        int rows = board.length;
        int cols = board[0].length;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (board[i][j] == 'r') {
                    int count = 0;
                    // Check up
                    for (int k = i - 1; k >= 0; k--) {
                        if (board[k][j] != '.') {
                            count++;
                            break;
                        }
                    }
                    // Check down
                    for (int k = i + 1; k < rows; k++) {
                        if (board[k][j] != '.') {
                            count++;
                            break;
                        }
                    }
                    // Check left
                    for (int k = j - 1; k >= 0; k--) {
                        if (board[i][k] != '.') {
                            count++;
                            break;
                        }
                    }
                    // Check right
                    for (int k = j + 1; k < cols; k++) {
                        if (board[i][k] != '.') {
                            count++;
                            break;
                        }
                    }
                    return count;
                }
            }
        }
        return 0;
    }
}
public class Solution {
    public int[] flipChess(char[][] board) {
        int[] result = new int[1];
        int rows = board.length;
        int cols = board[0].length;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (board[i][j] == ' ') {
                    int count = 0;
                    for (int dx = -1; dx <= 1; dx++) {
                        for (int dy = -1; dy <= 1; dy++) {
                            if (dx == 0 && dy == 0) continue;
                            int x = i + dx;
                            int y = j + dy;
                            int steps = 0;
                            while (x >= 0 && x < rows && y >= 0 && y < cols && board[x][y] == 'o') {
                                x += dx;
                                y += dy;
                                steps++;
                            }
                            if (x >= 0 && x < rows && y >= 0 && y < cols && board[x][y] == 'x' && steps > 0) {
                                count++;
                            }
                        }
                    }
                    if (count > 0) {
                        result[0] = count;
                    }
                }
            }
        }
        return result;
    }
}
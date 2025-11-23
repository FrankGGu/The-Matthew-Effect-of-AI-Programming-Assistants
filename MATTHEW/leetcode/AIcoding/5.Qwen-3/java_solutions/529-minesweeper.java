public class Solution {
    public char[][] updateBoard(char[][] board, int[] click) {
        int row = click[0], col = click[1];
        if (board[row][col] == 'M') {
            board[row][col] = 'X';
            return board;
        }
        if (board[row][col] != 'E') {
            return board;
        }
        int count = 0;
        int[][] directions = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};
        for (int[] dir : directions) {
            int x = row + dir[0];
            int y = col + dir[1];
            if (x >= 0 && x < board.length && y >= 0 && y < board[0].length && board[x][y] == 'M') {
                count++;
            }
        }
        if (count > 0) {
            board[row][col] = (char) ('0' + count);
            return board;
        }
        board[row][col] = 'B';
        for (int[] dir : directions) {
            int x = row + dir[0];
            int y = col + dir[1];
            if (x >= 0 && x < board.length && y >= 0 && y < board[0].length) {
                updateBoard(board, new int[]{x, y});
            }
        }
        return board;
    }
}
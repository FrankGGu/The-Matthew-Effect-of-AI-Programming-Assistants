class Solution {
    public boolean checkMove(char[][] board, int rMove, int cMove, char color) {
        int[][] directions = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};
        board[rMove][cMove] = color;

        for (int[] dir : directions) {
            int x = rMove + dir[0];
            int y = cMove + dir[1];
            int count = 0;

            while (x >= 0 && x < 8 && y >= 0 && y < 8 && board[x][y] != '.' && board[x][y] != color) {
                x += dir[0];
                y += dir[1];
                count++;
            }

            if (count >= 1 && x >= 0 && x < 8 && y >= 0 && y < 8 && board[x][y] == color) {
                return true;
            }
        }

        return false;
    }
}
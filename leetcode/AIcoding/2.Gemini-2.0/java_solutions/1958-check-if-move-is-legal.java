class Solution {
    public boolean checkMove(char[][] board, int rMove, int cMove, char color) {
        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}};
        for (int[] dir : directions) {
            int dr = dir[0];
            int dc = dir[1];
            int r = rMove + dr;
            int c = cMove + dc;
            int count = 0;
            while (r >= 0 && r < board.length && c >= 0 && c < board[0].length && board[r][c] != '.') {
                if (board[r][c] != color) {
                    count++;
                } else {
                    if (count >= 1) {
                        return true;
                    }
                    break;
                }
                r += dr;
                c += dc;
            }
        }
        return false;
    }
}
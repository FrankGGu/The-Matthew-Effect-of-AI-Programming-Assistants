public class Solution {
    public boolean checkMove(int[][] board, int rMove, int cMove, int color) {
        int opponentColor = color == 1 ? 2 : 1;
        boolean legalMove = false;
        int[][] directions = {{1, 0}, {0, 1}, {1, 1}, {1, -1}, {-1, 0}, {0, -1}, {-1, -1}, {-1, 1}};

        for (int[] dir : directions) {
            int x = rMove + dir[0], y = cMove + dir[1];
            boolean foundOpponent = false;

            while (x >= 0 && x < 8 && y >= 0 && y < 8) {
                if (board[x][y] == opponentColor) {
                    foundOpponent = true;
                } else if (board[x][y] == color) {
                    if (foundOpponent) {
                        legalMove = true;
                    }
                    break;
                } else {
                    break;
                }
                x += dir[0];
                y += dir[1];
            }
        }

        return legalMove && board[rMove][cMove] == 0;
    }
}
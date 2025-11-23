public class Solution {
    public boolean tour(int[][] board, int[] moveX, int[] moveY, int x, int y, int moveNum, int n) {
        if (moveNum == n * n) {
            return true;
        }
        for (int i = 0; i < 8; i++) {
            int nextX = x + moveX[i];
            int nextY = y + moveY[i];
            if (nextX >= 0 && nextX < n && nextY >= 0 && nextY < n && board[nextX][nextY] == -1) {
                board[nextX][nextY] = moveNum;
                if (tour(board, moveX, moveY, nextX, nextY, moveNum + 1, n)) {
                    return true;
                }
                board[nextX][nextY] = -1;
            }
        }
        return false;
    }

    public boolean checkTour(int[][] board, int n) {
        int[] moveX = {2, 1, -1, -2, -2, -1, 1, 2};
        int[] moveY = {1, 2, 2, 1, -1, -2, -2, -1};
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == 0) {
                    board[i][j] = 0;
                    if (tour(board, moveX, moveY, i, j, 1, n)) {
                        return true;
                    }
                    board[i][j] = -1;
                }
            }
        }
        return false;
    }
}
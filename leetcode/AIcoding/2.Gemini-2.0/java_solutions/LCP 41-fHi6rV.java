class Solution {
    public int flipChess(char[][] board) {
        int m = board.length;
        int n = board[0].length;
        int maxFlip = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == '.') {
                    maxFlip = Math.max(maxFlip, flip(board, i, j));
                }
            }
        }

        return maxFlip;
    }

    private int flip(char[][] board, int x, int y) {
        int m = board.length;
        int n = board[0].length;
        char[][] tempBoard = new char[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                tempBoard[i][j] = board[i][j];
            }
        }

        tempBoard[x][y] = 'X';
        int flipCount = 0;

        int[] dx = {-1, 1, 0, 0, -1, -1, 1, 1};
        int[] dy = {0, 0, -1, 1, -1, 1, -1, 1};

        for (int i = 0; i < 8; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];
            int count = 0;
            while (nx >= 0 && nx < m && ny >= 0 && ny < n && tempBoard[nx][ny] == 'O') {
                count++;
                nx += dx[i];
                ny += dy[i];
            }

            if (nx >= 0 && nx < m && ny >= 0 && ny < n && tempBoard[nx][ny] == 'X' && count > 0) {
                nx = x + dx[i];
                ny = y + dy[i];
                while (tempBoard[nx][ny] == 'O') {
                    tempBoard[nx][ny] = 'X';
                    flipCount++;
                    nx += dx[i];
                    ny += dy[i];
                }
            }
        }

        return flipCount;
    }
}
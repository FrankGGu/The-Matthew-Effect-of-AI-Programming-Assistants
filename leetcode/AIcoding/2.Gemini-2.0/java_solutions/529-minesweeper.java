class Solution {
    public int[] dx = {-1, -1, -1, 0, 0, 1, 1, 1};
    public int[] dy = {-1, 0, 1, -1, 1, -1, 0, 1};

    public char[][] updateBoard(char[][] board, int[] click) {
        int x = click[0], y = click[1];
        if (board[x][y] == 'M') {
            board[x][y] = 'X';
        } else {
            dfs(board, x, y);
        }
        return board;
    }

    public void dfs(char[][] board, int x, int y) {
        if (x < 0 || x >= board.length || y < 0 || y >= board[0].length || board[x][y] != 'E') {
            return;
        }
        int count = 0;
        for (int i = 0; i < 8; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];
            if (nx >= 0 && nx < board.length && ny >= 0 && ny < board[0].length && board[nx][ny] == 'M') {
                count++;
            }
        }
        if (count > 0) {
            board[x][y] = (char) ('0' + count);
        } else {
            board[x][y] = 'B';
            for (int i = 0; i < 8; i++) {
                int nx = x + dx[i];
                int ny = y + dy[i];
                dfs(board, nx, ny);
            }
        }
    }
}
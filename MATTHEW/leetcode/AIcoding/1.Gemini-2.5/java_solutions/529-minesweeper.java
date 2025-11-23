class Solution {
    private int[] dr = {-1, -1, -1, 0, 0, 1, 1, 1};
    private int[] dc = {-1, 0, 1, -1, 1, -1, 0, 1};
    private int rows;
    private int cols;

    public char[][] updateBoard(char[][] board, int[] click) {
        rows = board.length;
        cols = board[0].length;
        int r = click[0];
        int c = click[1];

        if (board[r][c] == 'M') {
            board[r][c] = 'X';
            return board;
        }

        // If it's 'E', proceed with DFS. If it's 'B' or a digit, do nothing.
        if (board[r][c] == 'E') {
            dfs(board, r, c);
        }

        return board;
    }

    private void dfs(char[][] board, int r, int c) {
        // Base case: out of bounds or not an unrevealed empty square ('E')
        if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != 'E') {
            return;
        }

        int mineCount = 0;
        // Count adjacent mines
        for (int i = 0; i < 8; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && board[nr][nc] == 'M') {
                mineCount++;
            }
        }

        if (mineCount > 0) {
            // If there are adjacent mines, reveal the number
            board[r][c] = (char) ('0' + mineCount);
        } else {
            // If no adjacent mines, reveal as 'B' and recursively reveal neighbors
            board[r][c] = 'B';
            for (int i = 0; i < 8; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];
                dfs(board, nr, nc);
            }
        }
    }
}
class Solution {
    public void solve(char[][] board) {
        if (board == null || board.length == 0 || board[0].length == 0) {
            return;
        }

        int m = board.length;
        int n = board[0].length;

        // Mark 'O's connected to borders with a temporary character, e.g., '#'
        // Top and bottom borders
        for (int j = 0; j < n; j++) {
            if (board[0][j] == 'O') {
                dfs(board, 0, j, m, n);
            }
            if (board[m - 1][j] == 'O') {
                dfs(board, m - 1, j, m, n);
            }
        }

        // Left and right borders
        for (int i = 0; i < m; i++) {
            if (board[i][0] == 'O') {
                dfs(board, i, 0, m, n);
            }
            if (board[i][n - 1] == 'O') {
                dfs(board, i, n - 1, m, n);
            }
        }

        // Traverse the board again
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == 'O') {
                    // 'O's not connected to borders are surrounded, flip to 'X'
                    board[i][j] = 'X';
                } else if (board[i][j] == '#') {
                    // '#'s were connected to borders, revert to 'O'
                    board[i][j] = 'O';
                }
            }
        }
    }

    private void dfs(char[][] board, int r, int c, int m, int n) {
        if (r < 0 || r >= m || c < 0 || c >= n || board[r][c] != 'O') {
            return;
        }

        board[r][c] = '#'; // Mark as visited and safe

        dfs(board, r + 1, c, m, n);
        dfs(board, r - 1, c, m, n);
        dfs(board, r, c + 1, m, n);
        dfs(board, r, c - 1, m, n);
    }
}
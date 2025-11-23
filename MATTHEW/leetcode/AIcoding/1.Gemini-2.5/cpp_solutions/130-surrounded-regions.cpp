class Solution {
public:
    void solve(std::vector<std::vector<char>>& board) {
        if (board.empty() || board[0].empty()) {
            return;
        }

        int m = board.size();
        int n = board[0].size();

        // Perform DFS from 'O's on the border
        // Top and bottom rows
        for (int c = 0; c < n; ++c) {
            if (board[0][c] == 'O') {
                dfs(board, 0, c, m, n);
            }
            if (board[m - 1][c] == 'O') {
                dfs(board, m - 1, c, m, n);
            }
        }

        // Left and right columns
        for (int r = 0; r < m; ++r) {
            if (board[r][0] == 'O') {
                dfs(board, r, 0, m, n);
            }
            if (board[r][n - 1] == 'O') {
                dfs(board, r, n - 1, m, n);
            }
        }

        // Iterate through the board to flip 'O's to 'X's and '#'s back to 'O's
        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (board[r][c] == 'O') {
                    board[r][c] = 'X';
                } else if (board[r][c] == '#') {
                    board[r][c] = 'O';
                }
            }
        }
    }

private:
    void dfs(std::vector<std::vector<char>>& board, int r, int c, int m, int n) {
        if (r < 0 || r >= m || c < 0 || c >= n || board[r][c] != 'O') {
            return;
        }

        board[r][c] = '#'; // Mark as visited and safe

        dfs(board, r + 1, c, m, n);
        dfs(board, r - 1, c, m, n);
        dfs(board, r, c + 1, m, n);
        dfs(board, r, c - 1, m, n);
    }
};
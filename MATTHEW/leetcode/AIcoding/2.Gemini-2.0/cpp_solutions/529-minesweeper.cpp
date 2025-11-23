#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<char>> updateBoard(vector<vector<char>>& board, vector<int>& click) {
        int row = click[0];
        int col = click[1];

        if (board[row][col] == 'M') {
            board[row][col] = 'X';
            return board;
        }

        int m = board.size();
        int n = board[0].size();

        vector<pair<int, int>> directions = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};

        function<void(int, int)> dfs = [&](int r, int c) {
            if (r < 0 || r >= m || c < 0 || c >= n || board[r][c] != 'E') {
                return;
            }

            int mineCount = 0;
            for (auto& dir : directions) {
                int nr = r + dir.first;
                int nc = c + dir.second;
                if (nr >= 0 && nr < m && nc >= 0 && nc < n && board[nr][nc] == 'M') {
                    mineCount++;
                }
            }

            if (mineCount > 0) {
                board[r][c] = mineCount + '0';
            } else {
                board[r][c] = 'B';
                for (auto& dir : directions) {
                    int nr = r + dir.first;
                    int nc = c + dir.second;
                    dfs(nr, nc);
                }
            }
        };

        dfs(row, col);
        return board;
    }
};
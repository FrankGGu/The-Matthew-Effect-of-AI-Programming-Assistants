class Solution {
public:
    vector<vector<char>> updateBoard(vector<vector<char>>& board, vector<int>& click) {
        int rows = board.size();
        int cols = board[0].size();
        int x = click[0], y = click[1];

        if (board[x][y] == 'M') {
            board[x][y] = 'X';
            return board;
        }

        vector<vector<int>> directions = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};

        function<int(int, int)> countMines = [&](int r, int c) {
            int count = 0;
            for (auto& dir : directions) {
                int newRow = r + dir[0];
                int newCol = c + dir[1];
                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && board[newRow][newCol] == 'M') {
                    count++;
                }
            }
            return count;
        };

        function<void(int, int)> dfs = [&](int r, int c) {
            if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != 'E') return;
            int mineCount = countMines(r, c);
            if (mineCount > 0) {
                board[r][c] = '0' + mineCount;
            } else {
                board[r][c] = 'B';
                for (auto& dir : directions) {
                    dfs(r + dir[0], c + dir[1]);
                }
            }
        };

        dfs(x, y);
        return board;
    }
};
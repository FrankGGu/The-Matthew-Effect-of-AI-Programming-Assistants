class Solution {
public:
    vector<vector<char>> updateBoard(vector<vector<char>>& board, vector<int>& click) {
        int x = click[0], y = click[1];
        if (board[x][y] == 'M') {
            board[x][y] = 'X';
            return board;
        }
        dfs(board, x, y);
        return board;
    }

private:
    void dfs(vector<vector<char>>& board, int x, int y) {
        if (x < 0 || x >= board.size() || y < 0 || y >= board[0].size() || board[x][y] != 'E') {
            return;
        }
        int mines = countMines(board, x, y);
        if (mines > 0) {
            board[x][y] = '0' + mines;
            return;
        }
        board[x][y] = 'B';
        for (int i = -1; i <= 1; ++i) {
            for (int j = -1; j <= 1; ++j) {
                if (i == 0 && j == 0) continue;
                dfs(board, x + i, y + j);
            }
        }
    }

    int countMines(vector<vector<char>>& board, int x, int y) {
        int count = 0;
        for (int i = -1; i <= 1; ++i) {
            for (int j = -1; j <= 1; ++j) {
                if (i == 0 && j == 0) continue;
                int nx = x + i, ny = y + j;
                if (nx >= 0 && nx < board.size() && ny >= 0 && ny < board[0].size() && board[nx][ny] == 'M') {
                    ++count;
                }
            }
        }
        return count;
    }
};
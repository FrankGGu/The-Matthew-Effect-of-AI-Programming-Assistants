class Solution {
public:
    bool exist(vector<vector<char>>& board, string word) {
        int rows = board.size();
        int cols = board[0].size();
        vector<vector<bool>> visited(rows, vector<bool>(cols, false));

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (dfs(board, word, 0, i, j, visited)) {
                    return true;
                }
            }
        }
        return false;
    }

private:
    bool dfs(vector<vector<char>>& board, const string& word, int index, int x, int y, vector<vector<bool>>& visited) {
        if (index == word.size()) return true;
        if (x < 0 || x >= board.size() || y < 0 || y >= board[0].size() || visited[x][y] || board[x][y] != word[index]) {
            return false;
        }

        visited[x][y] = true;
        bool found = dfs(board, word, index + 1, x + 1, y, visited) ||
                     dfs(board, word, index + 1, x - 1, y, visited) ||
                     dfs(board, word, index + 1, x, y + 1, visited) ||
                     dfs(board, word, index + 1, x, y - 1, visited);

        visited[x][y] = false;
        return found;
    }
};
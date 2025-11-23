class Solution {
public:
    bool exist(vector<vector<char>>& board, string word) {
        int m = board.size(), n = board[0].size();
        vector<vector<bool>> visited(m, vector<bool>(n, false));

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (dfs(board, word, i, j, 0, visited)) {
                    return true;
                }
            }
        }
        return false;
    }

private:
    bool dfs(vector<vector<char>>& board, const string& word, int i, int j, int index, vector<vector<bool>>& visited) {
        if (index == word.size()) return true;
        if (i < 0 || i >= board.size() || j < 0 || j >= board[0].size() || visited[i][j] || board[i][j] != word[index]) {
            return false;
        }

        visited[i][j] = true;
        bool found = dfs(board, word, i + 1, j, index + 1, visited) ||
                     dfs(board, word, i - 1, j, index + 1, visited) ||
                     dfs(board, word, i, j + 1, index + 1, visited) ||
                     dfs(board, word, i, j - 1, index + 1, visited);
        visited[i][j] = false;

        return found;
    }
};
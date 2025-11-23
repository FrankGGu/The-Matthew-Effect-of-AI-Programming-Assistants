class Solution {
public:
    bool exist(std::vector<std::vector<char>>& board, std::string word) {
        if (word.empty()) {
            return true;
        }
        if (board.empty() || board[0].empty()) {
            return false;
        }

        int rows = board.size();
        int cols = board[0].size();

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (board[i][j] == word[0]) {
                    if (dfs(board, word, i, j, 0)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

private:
    bool dfs(std::vector<std::vector<char>>& board, const std::string& word, int r, int c, int k) {
        if (k == word.length()) {
            return true;
        }

        if (r < 0 || r >= board.size() || c < 0 || c >= board[0].size() || board[r][c] != word[k]) {
            return false;
        }

        char originalChar = board[r][c];
        board[r][c] = '#'; 

        bool found = dfs(board, word, r + 1, c, k + 1) ||
                     dfs(board, word, r - 1, c, k + 1) ||
                     dfs(board, word, r, c + 1, k + 1) ||
                     dfs(board, word, r, c - 1, k + 1);

        board[r][c] = originalChar; 

        return found;
    }
};
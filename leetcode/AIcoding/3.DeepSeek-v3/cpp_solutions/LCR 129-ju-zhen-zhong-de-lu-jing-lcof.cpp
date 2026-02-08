class Solution {
public:
    bool exist(vector<vector<char>>& board, string word) {
        rows = board.size();
        cols = board[0].size();
        this->word = word;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (dfs(board, i, j, 0)) {
                    return true;
                }
            }
        }
        return false;
    }

private:
    int rows, cols;
    string word;
    bool dfs(vector<vector<char>>& board, int i, int j, int index) {
        if (index == word.size()) {
            return true;
        }
        if (i < 0 || i >= rows || j < 0 || j >= cols || board[i][j] != word[index]) {
            return false;
        }
        char temp = board[i][j];
        board[i][j] = '#';
        bool found = dfs(board, i + 1, j, index + 1) ||
                     dfs(board, i - 1, j, index + 1) ||
                     dfs(board, i, j + 1, index + 1) ||
                     dfs(board, i, j - 1, index + 1);
        board[i][j] = temp;
        return found;
    }
};
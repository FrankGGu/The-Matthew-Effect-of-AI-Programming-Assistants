class Solution {
public:
    bool placeWordInCrossword(vector<vector<char>>& board, string word) {
        int m = board.size(), n = board[0].size();
        int len = word.size();
        vector<vector<char>> transposed(n, vector<char>(m));
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                transposed[j][i] = board[i][j];
            }
        }
        return check(board, word) || check(transposed, word);
    }

    bool check(vector<vector<char>>& board, string& word) {
        int m = board.size(), n = board[0].size();
        int len = word.size();
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j <= n - len; ++j) {
                bool match = true;
                for (int k = 0; k < len; ++k) {
                    if (board[i][j + k] != ' ' && board[i][j + k] != word[k]) {
                        match = false;
                        break;
                    }
                }
                if (match && (j == 0 || board[i][j - 1] == '#') && (j + len == n || board[i][j + len] == '#')) {
                    return true;
                }
                match = true;
                for (int k = 0; k < len; ++k) {
                    if (board[i][j + k] != ' ' && board[i][j + k] != word[len - 1 - k]) {
                        match = false;
                        break;
                    }
                }
                if (match && (j == 0 || board[i][j - 1] == '#') && (j + len == n || board[i][j + len] == '#')) {
                    return true;
                }
            }
        }
        return false;
    }
};
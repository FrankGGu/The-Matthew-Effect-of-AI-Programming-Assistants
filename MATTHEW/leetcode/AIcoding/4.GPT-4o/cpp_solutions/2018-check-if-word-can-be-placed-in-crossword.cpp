class Solution {
public:
    bool placeWordInCrossword(vector<vector<char>>& board, string word) {
        int m = board.size(), n = board[0].size();

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (board[i][j] == '#' || j + word.size() > n && i + word.size() > m) continue;

                if (j + word.size() <= n && canPlace(board, word, i, j, 0, 1)) return true;
                if (i + word.size() <= m && canPlace(board, word, i, j, 1, 0)) return true;
            }
        }
        return false;
    }

    bool canPlace(vector<vector<char>>& board, string& word, int x, int y, int dx, int dy) {
        for (int k = 0; k < word.size(); ++k) {
            if (board[x + k * dx][y + k * dy] == '#' || 
                (board[x + k * dx][y + k * dy] != ' ' && board[x + k * dx][y + k * dy] != word[k]))
                return false;
        }
        if ((x > 0 && board[x - 1][y] != '#') || (x + word.size() < board.size() && board[x + word.size()][y] != '#'))
            return true;
        if ((y > 0 && board[x][y - 1] != '#') || (y + word.size() < board[0].size() && board[x][y + word.size()] != '#'))
            return true;
        return false;
    }
};
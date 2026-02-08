class Solution {
public:
    bool placeWordInCrossword(vector<vector<char>>& board, string word) {
        int m = board.size(), n = board[0].size(), len = word.length();
        auto check = [&](int r, int c, int dr, int dc) {
            int i = 0;
            while (i < len) {
                if (r < 0 || r >= m || c < 0 || c >= n || (board[r][c] != ' ' && board[r][c] != word[i])) {
                    return false;
                }
                r += dr;
                c += dc;
                i++;
            }
            return (r < 0 || r >= m || c < 0 || c >= n || board[r][c] == '#');
        };
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == '#') continue;
                if ((j == 0 || board[i][j - 1] == '#') && j + len <= n && (j + len == n || board[i][j + len] == '#')) {
                    if (check(i, j, 0, 1)) {
                        bool match = true;
                        for (int k = 0; k < len; k++) {
                            if (board[i][j + k] != ' ' && board[i][j + k] != word[k]) {
                                match = false;
                                break;
                            }
                        }
                        if (match) return true;
                    }
                }
                if ((j == n - 1 || board[i][j + 1] == '#') && j - len + 1 >= 0 && (j - len == -1 || board[i][j - len] == '#')) {
                    if (check(i, j, 0, -1)) {
                        bool match = true;
                        for (int k = 0; k < len; k++) {
                            if (board[i][j - k] != ' ' && board[i][j - k] != word[k]) {
                                match = false;
                                break;
                            }
                        }
                        if (match) return true;
                    }
                }
                if ((i == 0 || board[i - 1][j] == '#') && i + len <= m && (i + len == m || board[i + len][j] == '#')) {
                    if (check(i, j, 1, 0)) {
                        bool match = true;
                        for (int k = 0; k < len; k++) {
                            if (board[i + k][j] != ' ' && board[i + k][j] != word[k]) {
                                match = false;
                                break;
                            }
                        }
                        if (match) return true;
                    }
                }
                if ((i == m - 1 || board[i + 1][j] == '#') && i - len + 1 >= 0 && (i - len == -1 || board[i - len][j] == '#')) {
                    if (check(i, j, -1, 0)) {
                        bool match = true;
                        for (int k = 0; k < len; k++) {
                            if (board[i - k][j] != ' ' && board[i - k][j] != word[k]) {
                                match = false;
                                break;
                            }
                        }
                        if (match) return true;
                    }
                }
            }
        }
        reverse(word.begin(), word.end());
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j] == '#') continue;
                if ((j == 0 || board[i][j - 1] == '#') && j + len <= n && (j + len == n || board[i][j + len] == '#')) {
                    if (check(i, j, 0, 1)) {
                        bool match = true;
                        for (int k = 0; k < len; k++) {
                            if (board[i][j + k] != ' ' && board[i][j + k] != word[k]) {
                                match = false;
                                break;
                            }
                        }
                        if (match) return true;
                    }
                }
                if ((j == n - 1 || board[i][j + 1] == '#') && j - len + 1 >= 0 && (j - len == -1 || board[i][j - len] == '#')) {
                    if (check(i, j, 0, -1)) {
                        bool match = true;
                        for (int k = 0; k < len; k++) {
                            if (board[i][j - k] != ' ' && board[i][j - k] != word[k]) {
                                match = false;
                                break;
                            }
                        }
                        if (match) return true;
                    }
                }
                if ((i == 0 || board[i - 1][j] == '#') && i + len <= m && (i + len == m || board[i + len][j] == '#')) {
                    if (check(i, j, 1, 0)) {
                        bool match = true;
                        for (int k = 0; k < len; k++) {
                            if (board[i + k][j] != ' ' && board[i + k][j] != word[k]) {
                                match = false;
                                break;
                            }
                        }
                        if (match) return true;
                    }
                }
                if ((i == m - 1 || board[i + 1][j] == '#') && i - len + 1 >= 0 && (i - len == -1 || board[i - len][j] == '#')) {
                    if (check(i, j, -1, 0)) {
                        bool match = true;
                        for (int k = 0; k < len; k++) {
                            if (board[i - k][j] != ' ' && board[i - k][j] != word[k]) {
                                match = false;
                                break;
                            }
                        }
                        if (match) return true;
                    }
                }
            }
        }
        return false;
    }
};
#include <vector>
#include <string>

class Solution {
public:
    bool exist(std::vector<std::vector<char>>& board, std::string word) {
        if (board.empty() || board[0].empty()) {
            return false;
        }
        if (word.empty()) {
            return true;
        }

        int rows = board.size();
        int cols = board[0].size();

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (board[i][j] == word[0]) {
                    if (dfs(board, word, i, j, 0, rows, cols)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

private:
    bool dfs(std::vector<std::vector<char>>& board, const std::string& word, int r, int c, int k, int rows, int cols) {
        if (k == word.length()) {
            return true;
        }

        if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != word[k]) {
            return false;
        }

        char original_char = board[r][c];
        board[r][c] = '#'; 

        bool found = dfs(board, word, r + 1, c, k + 1, rows, cols) ||
                     dfs(board, word, r - 1, c, k + 1, rows, cols) ||
                     dfs(board, word, r, c + 1, k + 1, rows, cols) ||
                     dfs(board, word, r, c - 1, k + 1, rows, cols);

        board[r][c] = original_char; 
        return found;
    }
};
#include <vector>
#include <string>

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
                    if (dfs(board, i, j, word, 0)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

private:
    bool dfs(std::vector<std::vector<char>>& board, int r, int c, const std::string& word, int index) {
        if (index == word.length()) {
            return true;
        }

        int rows = board.size();
        int cols = board[0].size();

        if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != word[index]) {
            return false;
        }

        char originalChar = board[r][c];
        board[r][c] = '#'; 

        if (dfs(board, r + 1, c, word, index + 1) ||
            dfs(board, r - 1, c, word, index + 1) ||
            dfs(board, r, c + 1, word, index + 1) ||
            dfs(board, r, c - 1, word, index + 1)) {
            return true;
        }

        board[r][c] = originalChar; 
        return false;
    }
};
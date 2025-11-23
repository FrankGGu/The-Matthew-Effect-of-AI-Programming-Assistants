#include <vector>

using namespace std;

class Solution {
public:
    bool exist(vector<vector<char>>& board, string word) {
        int m = board.size();
        int n = board[0].size();

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (dfs(board, i, j, word, 0)) {
                    return true;
                }
            }
        }

        return false;
    }

private:
    bool dfs(vector<vector<char>>& board, int row, int col, string& word, int index) {
        if (index == word.length()) {
            return true;
        }

        if (row < 0 || row >= board.size() || col < 0 || col >= board[0].size() || board[row][col] != word[index]) {
            return false;
        }

        char temp = board[row][col];
        board[row][col] = '#'; 

        bool found = dfs(board, row + 1, col, word, index + 1) ||
                     dfs(board, row - 1, col, word, index + 1) ||
                     dfs(board, row, col + 1, word, index + 1) ||
                     dfs(board, row, col - 1, word, index + 1);

        board[row][col] = temp; 
        return found;
    }
};
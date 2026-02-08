#include <vector>

using namespace std;

class Solution {
public:
    bool exist(vector<vector<char>>& board, string word) {
        int m = board.size();
        int n = board[0].size();

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (board[i][j] == word[0]) {
                    vector<vector<bool>> visited(m, vector<bool>(n, false));
                    if (dfs(board, word, i, j, 0, visited)) {
                        return true;
                    }
                }
            }
        }

        return false;
    }

private:
    bool dfs(vector<vector<char>>& board, string word, int row, int col, int index, vector<vector<bool>>& visited) {
        if (index == word.length()) {
            return true;
        }

        if (row < 0 || row >= board.size() || col < 0 || col >= board[0].size() || visited[row][col] || board[row][col] != word[index]) {
            return false;
        }

        visited[row][col] = true;

        bool found = dfs(board, word, row + 1, col, index + 1, visited) ||
                     dfs(board, word, row - 1, col, index + 1, visited) ||
                     dfs(board, word, row, col + 1, index + 1, visited) ||
                     dfs(board, word, row, col - 1, index + 1, visited);

        visited[row][col] = false;

        return found;
    }
};
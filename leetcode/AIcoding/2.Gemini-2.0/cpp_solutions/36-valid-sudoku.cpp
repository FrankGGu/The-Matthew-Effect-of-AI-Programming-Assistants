#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool isValidSudoku(vector<vector<char>>& board) {
        for (int i = 0; i < 9; ++i) {
            unordered_set<char> rowSet;
            unordered_set<char> colSet;
            unordered_set<char> boxSet;

            for (int j = 0; j < 9; ++j) {
                if (board[i][j] != '.') {
                    if (rowSet.count(board[i][j])) return false;
                    rowSet.insert(board[i][j]);
                }

                if (board[j][i] != '.') {
                    if (colSet.count(board[j][i])) return false;
                    colSet.insert(board[j][i]);
                }

                int row = 3 * (i / 3) + j / 3;
                int col = 3 * (i % 3) + j % 3;
                if (board[row][col] != '.') {
                    if (boxSet.count(board[row][col])) return false;
                    boxSet.insert(board[row][col]);
                }
            }
        }
        return true;
    }
};
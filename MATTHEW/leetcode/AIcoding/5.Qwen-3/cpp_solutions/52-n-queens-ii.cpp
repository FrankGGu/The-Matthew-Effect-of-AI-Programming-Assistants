#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int totalNQueens(int n) {
        vector<int> board(n, -1);
        int count = 0;
        backtrack(board, 0, count, n);
        return count;
    }

private:
    void backtrack(vector<int>& board, int row, int& count, int n) {
        if (row == n) {
            ++count;
            return;
        }
        for (int col = 0; col < n; ++col) {
            if (isValid(board, row, col)) {
                board[row] = col;
                backtrack(board, row + 1, count, n);
                board[row] = -1;
            }
        }
    }

    bool isValid(const vector<int>& board, int row, int col) {
        for (int i = 0; i < row; ++i) {
            int prevCol = board[i];
            if (prevCol == col || abs(row - i) == abs(col - prevCol)) {
                return false;
            }
        }
        return true;
    }
};
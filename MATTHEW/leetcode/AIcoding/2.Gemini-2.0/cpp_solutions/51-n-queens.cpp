#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<vector<string>> solveNQueens(int n) {
        vector<vector<string>> solutions;
        vector<int> queens(n);
        solveNQueensHelper(solutions, queens, 0, n);
        return solutions;
    }

private:
    void solveNQueensHelper(vector<vector<string>>& solutions, vector<int>& queens, int row, int n) {
        if (row == n) {
            vector<string> board(n, string(n, '.'));
            for (int i = 0; i < n; ++i) {
                board[i][queens[i]] = 'Q';
            }
            solutions.push_back(board);
            return;
        }

        for (int col = 0; col < n; ++col) {
            if (isSafe(queens, row, col)) {
                queens[row] = col;
                solveNQueensHelper(solutions, queens, row + 1, n);
            }
        }
    }

    bool isSafe(vector<int>& queens, int row, int col) {
        for (int i = 0; i < row; ++i) {
            if (queens[i] == col || abs(queens[i] - col) == row - i) {
                return false;
            }
        }
        return true;
    }
};
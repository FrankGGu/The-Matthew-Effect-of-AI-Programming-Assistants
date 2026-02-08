#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::vector<std::string>> solveNQueens(int n) {
        std::vector<std::vector<std::string>> res;
        std::vector<std::string> board(n, std::string(n, '.'));
        std::vector<bool> cols(n, false);
        std::vector<bool> diag1(2 * n - 1, false);
        std::vector<bool> diag2(2 * n - 1, false);
        backtrack(0, n, board, res, cols, diag1, diag2);
        return res;
    }

private:
    void backtrack(int row, int n, std::vector<std::string>& board,
                   std::vector<std::vector<std::string>>& res,
                   std::vector<bool>& cols, std::vector<bool>& diag1,
                   std::vector<bool>& diag2) {
        if (row == n) {
            res.push_back(board);
            return;
        }

        for (int col = 0; col < n; ++col) {
            int d1_idx = row - col + n - 1;
            int d2_idx = row + col;

            if (cols[col] || diag1[d1_idx] || diag2[d2_idx]) {
                continue;
            }

            board[row][col] = 'Q';
            cols[col] = true;
            diag1[d1_idx] = true;
            diag2[d2_idx] = true;

            backtrack(row + 1, n, board, res, cols, diag1, diag2);

            board[row][col] = '.';
            cols[col] = false;
            diag1[d1_idx] = false;
            diag2[d2_idx] = false;
        }
    }
};
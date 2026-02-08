#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    int totalNQueens(int n) {
        int count = 0;
        std::vector<bool> col(n, false);
        std::vector<bool> diag1(2 * n - 1, false); // r + c
        std::vector<bool> diag2(2 * n - 1, false); // r - c + n - 1

        backtrack(0, n, col, diag1, diag2, count);
        return count;
    }

private:
    void backtrack(int r, int n,
                   std::vector<bool>& col,
                   std::vector<bool>& diag1,
                   std::vector<bool>& diag2,
                   int& count) {
        if (r == n) {
            count++;
            return;
        }

        for (int c = 0; c < n; ++c) {
            if (col[c] || diag1[r + c] || diag2[r - c + n - 1]) {
                continue;
            }

            col[c] = true;
            diag1[r + c] = true;
            diag2[r - c + n - 1] = true;

            backtrack(r + 1, n, col, diag1, diag2, count);

            col[c] = false;
            diag1[r + c] = false;
            diag2[r - c + n - 1] = false;
        }
    }
};
class Solution {
public:
    int totalNQueens(int n) {
        int count = 0;
        vector<bool> cols(n, false);
        vector<bool> diag1(2 * n - 1, false);
        vector<bool> diag2(2 * n - 1, false);

        function<void(int)> solve = [&](int row) {
            if (row == n) {
                count++;
                return;
            }

            for (int col = 0; col < n; ++col) {
                if (!cols[col] && !diag1[row + col] && !diag2[row - col + n - 1]) {
                    cols[col] = true;
                    diag1[row + col] = true;
                    diag2[row - col + n - 1] = true;
                    solve(row + 1);
                    cols[col] = false;
                    diag1[row + col] = false;
                    diag2[row - col + n - 1] = false;
                }
            }
        };

        solve(0);
        return count;
    }
};
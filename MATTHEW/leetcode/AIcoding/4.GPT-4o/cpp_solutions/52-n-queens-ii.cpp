class Solution {
public:
    int totalNQueens(int n) {
        vector<int> cols(n, 0), diag1(2 * n, 0), diag2(2 * n, 0);
        return solve(n, 0, cols, diag1, diag2);
    }

    int solve(int n, int row, vector<int>& cols, vector<int>& diag1, vector<int>& diag2) {
        if (row == n) return 1;
        int count = 0;
        for (int col = 0; col < n; ++col) {
            if (!cols[col] && !diag1[row + col] && !diag2[row - col + n]) {
                cols[col] = diag1[row + col] = diag2[row - col + n] = 1;
                count += solve(n, row + 1, cols, diag1, diag2);
                cols[col] = diag1[row + col] = diag2[row - col + n] = 0;
            }
        }
        return count;
    }
};
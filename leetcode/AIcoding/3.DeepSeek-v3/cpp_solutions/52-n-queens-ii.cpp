class Solution {
public:
    int totalNQueens(int n) {
        int count = 0;
        vector<int> queens(n, -1);
        solve(queens, 0, count);
        return count;
    }

private:
    void solve(vector<int>& queens, int row, int& count) {
        int n = queens.size();
        if (row == n) {
            count++;
            return;
        }
        for (int col = 0; col < n; col++) {
            if (isValid(queens, row, col)) {
                queens[row] = col;
                solve(queens, row + 1, count);
                queens[row] = -1;
            }
        }
    }

    bool isValid(vector<int>& queens, int row, int col) {
        for (int i = 0; i < row; i++) {
            if (queens[i] == col || abs(row - i) == abs(col - queens[i])) {
                return false;
            }
        }
        return true;
    }
};
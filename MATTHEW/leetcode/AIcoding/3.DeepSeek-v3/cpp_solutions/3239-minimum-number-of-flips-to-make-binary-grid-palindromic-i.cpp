class Solution {
public:
    int minFlips(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        int res = 0;
        for (int i = 0; i < m / 2; ++i) {
            for (int j = 0; j < n / 2; ++j) {
                int a = grid[i][j];
                int b = grid[i][n - 1 - j];
                int c = grid[m - 1 - i][j];
                int d = grid[m - 1 - i][n - 1 - j];
                int sum = a + b + c + d;
                res += min(sum, 4 - sum);
            }
        }
        if (m % 2 == 1) {
            for (int j = 0; j < n / 2; ++j) {
                int a = grid[m / 2][j];
                int b = grid[m / 2][n - 1 - j];
                res += (a != b);
            }
        }
        if (n % 2 == 1) {
            for (int i = 0; i < m / 2; ++i) {
                int a = grid[i][n / 2];
                int b = grid[m - 1 - i][n / 2];
                res += (a != b);
            }
        }
        return res;
    }
};
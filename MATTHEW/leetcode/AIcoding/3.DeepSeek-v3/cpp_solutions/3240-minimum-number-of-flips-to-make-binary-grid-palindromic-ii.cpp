class Solution {
public:
    int minFlips(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        int res = 0;

        for (int i = 0; i < m / 2; ++i) {
            for (int j = 0; j < n / 2; ++j) {
                int cnt = grid[i][j] + grid[i][n - 1 - j] + grid[m - 1 - i][j] + grid[m - 1 - i][n - 1 - j];
                res += min(cnt, 4 - cnt);
            }
        }

        if (m % 2 == 1) {
            int i = m / 2;
            for (int j = 0; j < n / 2; ++j) {
                if (grid[i][j] != grid[i][n - 1 - j]) {
                    res++;
                }
            }
        }

        if (n % 2 == 1) {
            int j = n / 2;
            for (int i = 0; i < m / 2; ++i) {
                if (grid[i][j] != grid[m - 1 - i][j]) {
                    res++;
                }
            }
        }

        return res;
    }
};
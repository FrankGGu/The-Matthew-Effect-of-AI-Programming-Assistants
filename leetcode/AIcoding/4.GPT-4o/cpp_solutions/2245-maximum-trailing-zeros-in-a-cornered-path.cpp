class Solution {
public:
    int maxTrailingZeros(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> count2(m + 1, vector<int>(n + 1, 0));
        vector<vector<int>> count5(m + 1, vector<int>(n + 1, 0));

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                int num = grid[i - 1][j - 1];
                while (num % 2 == 0) {
                    count2[i][j]++;
                    num /= 2;
                }
                num = grid[i - 1][j - 1];
                while (num % 5 == 0) {
                    count5[i][j]++;
                    num /= 5;
                }
                count2[i][j] += count2[i - 1][j] + count2[i][j - 1] - count2[i - 1][j - 1];
                count5[i][j] += count5[i - 1][j] + count5[i][j - 1] - count5[i - 1][j - 1];
            }
        }

        int maxZeros = 0;
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                maxZeros = max(maxZeros, min(count2[i][j], count5[i][j]));
            }
        }

        return maxZeros;
    }
};
class Solution {
public:
    int maxTrailingZeros(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<pair<int, int>>> row_prefix(m, vector<pair<int, int>>(n + 1, {0, 0}));
        vector<vector<pair<int, int>>> col_prefix(n, vector<pair<int, int>>(m + 1, {0, 0}));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int twos = 0, fives = 0;
                int num = grid[i][j];
                while (num % 2 == 0 && num > 0) {
                    twos++;
                    num /= 2;
                }
                while (num % 5 == 0 && num > 0) {
                    fives++;
                    num /= 5;
                }
                row_prefix[i][j + 1].first = row_prefix[i][j].first + twos;
                row_prefix[i][j + 1].second = row_prefix[i][j].second + fives;
            }
        }

        for (int j = 0; j < n; ++j) {
            for (int i = 0; i < m; ++i) {
                int twos = 0, fives = 0;
                int num = grid[i][j];
                while (num % 2 == 0 && num > 0) {
                    twos++;
                    num /= 2;
                }
                while (num % 5 == 0 && num > 0) {
                    fives++;
                    num /= 5;
                }
                col_prefix[j][i + 1].first = col_prefix[j][i].first + twos;
                col_prefix[j][i + 1].second = col_prefix[j][i].second + fives;
            }
        }

        int max_zeros = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int twos = 0, fives = 0;
                int num = grid[i][j];
                while (num % 2 == 0 && num > 0) {
                    twos++;
                    num /= 2;
                }
                while (num % 5 == 0 && num > 0) {
                    fives++;
                    num /= 5;
                }

                int path1_twos = row_prefix[i][j + 1].first + col_prefix[j][m].first - col_prefix[j][i].first - twos;
                int path1_fives = row_prefix[i][j + 1].second + col_prefix[j][m].second - col_prefix[j][i].second - fives;
                max_zeros = max(max_zeros, min(path1_twos, path1_fives));

                int path2_twos = row_prefix[i][n].first - row_prefix[i][j].first + col_prefix[j][i + 1].first - twos;
                int path2_fives = row_prefix[i][n].second - row_prefix[i][j].second + col_prefix[j][i + 1].second - fives;
                max_zeros = max(max_zeros, min(path2_twos, path2_fives));

                int path3_twos = row_prefix[i][j + 1].first + col_prefix[j][i + 1].first - twos;
                int path3_fives = row_prefix[i][j + 1].second + col_prefix[j][i + 1].second - fives;
                max_zeros = max(max_zeros, min(path3_twos, path3_fives));

                int path4_twos = row_prefix[i][n].first - row_prefix[i][j].first + col_prefix[j][m].first - col_prefix[j][i].first - twos;
                int path4_fives = row_prefix[i][n].second - row_prefix[i][j].second + col_prefix[j][m].second - col_prefix[j][i].second - fives;
                max_zeros = max(max_zeros, min(path4_twos, path4_fives));
            }
        }

        return max_zeros;
    }
};
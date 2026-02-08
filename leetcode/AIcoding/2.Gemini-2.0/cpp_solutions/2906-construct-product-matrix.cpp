#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> constructProductMatrix(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> ans(m, vector<int>(n, 1));
        long long mod = 12345;

        vector<vector<long long>> prefix(m, vector<long long>(n, 1));
        vector<vector<long long>> suffix(m, vector<long long>(n, 1));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == 0 && j == 0) {
                    prefix[i][j] = grid[i][j] % mod;
                } else if (j == 0) {
                    prefix[i][j] = (prefix[i - 1][n - 1] * grid[i][j]) % mod;
                } else {
                    prefix[i][j] = (prefix[i][j - 1] * grid[i][j]) % mod;
                }
            }
        }

        for (int i = m - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (i == m - 1 && j == n - 1) {
                    suffix[i][j] = grid[i][j] % mod;
                } else if (j == n - 1) {
                    suffix[i][j] = (suffix[i + 1][0] * grid[i][j]) % mod;
                } else {
                    suffix[i][j] = (suffix[i][j + 1] * grid[i][j]) % mod;
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                long long pre = 1;
                long long suf = 1;
                if (i == 0 && j == 0) {
                    pre = 1;
                } else if (j == 0) {
                    pre = prefix[i - 1][n - 1];
                } else {
                    pre = prefix[i][j - 1];
                }

                if (i == m - 1 && j == n - 1) {
                    suf = 1;
                } else if (j == n - 1) {
                    suf = suffix[i + 1][0];
                } else {
                    suf = suffix[i][j + 1];
                }

                ans[i][j] = (pre * suf) % mod;
            }
        }

        return ans;
    }
};
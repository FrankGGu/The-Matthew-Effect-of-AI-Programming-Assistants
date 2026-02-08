#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minFlips(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        int ans = INT_MAX;

        for (int mask = 0; mask < (1 << m); ++mask) {
            int flips = 0;
            vector<vector<int>> temp_grid = grid;

            for (int i = 0; i < m; ++i) {
                if ((mask >> i) & 1) {
                    flips++;
                    for (int j = 0; j < n; ++j) {
                        temp_grid[i][j] = 1 - temp_grid[i][j];
                    }
                }
            }

            bool is_palindromic = true;
            for (int j = 0; j < n; ++j) {
                for (int i = 0; i < m / 2; ++i) {
                    if (temp_grid[i][j] != temp_grid[m - 1 - i][j]) {
                        is_palindromic = false;
                        break;
                    }
                }
                if (!is_palindromic) break;
            }

            if (is_palindromic) {
                ans = min(ans, flips);
            }
        }

        return (ans == INT_MAX) ? -1 : ans;
    }
};
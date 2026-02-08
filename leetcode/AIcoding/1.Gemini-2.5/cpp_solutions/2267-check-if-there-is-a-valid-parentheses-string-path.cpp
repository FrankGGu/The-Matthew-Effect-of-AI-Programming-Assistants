#include <vector>
#include <string>
#include <bitset>

class Solution {
public:
    bool hasValidPath(std::vector<std::vector<char>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        if (grid[0][0] == ')') return false;
        if (grid[m - 1][n - 1] == '(') return false;
        if ((m + n - 1) % 2 != 0) return false;

        std::vector<std::vector<std::bitset<201>>> dp(m, std::vector<std::bitset<201>>(n));

        if (grid[0][0] == '(') {
            dp[0][0][1] = true;
        }

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (r == 0 && c == 0) continue;

                std::bitset<201> prev_balances;

                if (r > 0) {
                    prev_balances |= dp[r - 1][c];
                }
                if (c > 0) {
                    prev_balances |= dp[r][c - 1];
                }

                if (grid[r][c] == '(') {
                    dp[r][c] = (prev_balances << 1);
                } else {
                    dp[r][c] = (prev_balances >> 1);
                }
            }
        }

        return dp[m - 1][n - 1][0];
    }
};
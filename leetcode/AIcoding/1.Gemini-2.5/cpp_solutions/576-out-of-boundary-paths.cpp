#include <vector>

class Solution {
public:
    int findPaths(int m, int n, int maxMove, int startRow, int startColumn) {
        int MOD = 1e9 + 7;
        std::vector<std::vector<int>> dp(m, std::vector<int>(n, 0));
        dp[startRow][startColumn] = 1;
        int count = 0;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        for (int moves = 0; moves < maxMove; ++moves) {
            std::vector<std::vector<int>> temp(m, std::vector<int>(n, 0));
            for (int r = 0; r < m; ++r) {
                for (int c = 0; c < n; ++c) {
                    if (dp[r][c] > 0) {
                        for (int i = 0; i < 4; ++i) {
                            int nr = r + dr[i];
                            int nc = c + dc[i];

                            if (nr < 0 || nr >= m || nc < 0 || nc >= n) {
                                count = (count + dp[r][c]) % MOD;
                            } else {
                                temp[nr][nc] = (temp[nr][nc] + dp[r][c]) % MOD;
                            }
                        }
                    }
                }
            }
            dp = temp;
        }

        return count;
    }
};
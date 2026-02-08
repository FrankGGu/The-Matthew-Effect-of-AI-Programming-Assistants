class Solution {
public:
    int numberOfPaths(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();
        long long MOD = 1e9 + 7;

        // dp[i][j][rem] stores the number of paths from (0,0) to (i,j)
        // such that the sum of elements along the path modulo k is 'rem'.
        vector<vector<vector<int>>> dp(m, vector<vector<int>>(n, vector<int>(k, 0)));

        // Base case: starting cell (0,0)
        dp[0][0][grid[0][0] % k] = 1;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int current_val = grid[i][j];

                // Iterate over all possible remainders from previous cells
                for (int rem = 0; rem < k; ++rem) {
                    // If there are paths to (i,j) with sum_mod 'rem' (excluding current_val)
                    // This is not correct. We should iterate over previous remainders.
                    // Let's re-think the loop for state transition.

                    // dp[i][j][new_rem] is formed by adding current_val to paths ending at (i-1,j) or (i,j-1)
                    // with some remainder 'prev_rem'.
                    // new_rem = (prev_rem + current_val) % k

                    if (i == 0 && j == 0) continue; // Base case already handled

                    // From cell above (i-1, j)
                    if (i > 0) {
                        for (int prev_rem = 0; prev_rem < k; ++prev_rem) {
                            if (dp[i - 1][j][prev_rem] > 0) {
                                int new_rem = (prev_rem + current_val) % k;
                                dp[i][j][new_rem] = (dp[i][j][new_rem] + dp[i - 1][j][prev_rem]) % MOD;
                            }
                        }
                    }

                    // From cell to the left (i, j-1)
                    if (j > 0) {
                        for (int prev_rem = 0; prev_rem < k; ++prev_rem) {
                            if (dp[i][j - 1][prev_rem] > 0) {
                                int new_rem = (prev_rem + current_val) % k;
                                dp[i][j][new_rem] = (dp[i][j][new_rem] + dp[i][j - 1][prev_rem]) % MOD;
                            }
                        }
                    }
                }
            }
        }

        return dp[m - 1][n - 1][0];
    }
};
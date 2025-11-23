#include <vector>
#include <numeric>

class Solution {
public:
    int numberOfSets(int n, int k) {
        long long MOD = 1e9 + 7;

        // dp_prev[j] stores the number of ways to place j segments using points up to i-1
        // S_prev[j] stores the sum of dp[p][j] for p from 0 to i-1
        std::vector<long long> dp_prev(k + 1, 0);
        std::vector<long long> S_prev(k + 1, 0);

        // Base case for i = 0 (points up to 0, i.e., only point 0)
        // dp[0][0] = 1 (1 way to choose 0 segments from 0 points)
        dp_prev[0] = 1;
        // S[0][0] = 1 (sum of dp[p][0] for p=0 is dp[0][0])
        S_prev[0] = 1;

        // Iterate through the available rightmost point 'i' (from 1 to n)
        // 'i' represents the largest point index available (points 0, 1, ..., i)
        for (int i = 1; i <= n; ++i) {
            std::vector<long long> dp_curr(k + 1, 0);
            std::vector<long long> S_curr(k + 1, 0);

            // Base case for j = 0 (0 segments)
            dp_curr[0] = 1;
            S_curr[0] = (S_prev[0] + dp_curr[0]) % MOD;

            // Iterate through the number of segments 'j'
            for (int j = 1; j <= k; ++j) {
                // Case 1: No segment ends at point 'i'.
                // All 'j' segments are formed using points 0 to i-1.
                // This count is dp_prev[j].
                dp_curr[j] = dp_prev[j];

                // Case 2: The j-th segment ends at point 'i'. Let this segment be [p, i].
                // The previous j-1 segments must be formed using points 0 to p.
                // We need to sum dp[p][j-1] for p from 0 to i-1.
                // This sum is S_prev[j-1].
                dp_curr[j] = (dp_curr[j] + S_prev[j-1]) % MOD;

                // Update S_curr[j] for the current 'i'.
                // S_curr[j] is the sum of dp[x][j] for x from 0 to i.
                // S_curr[j] = S[i-1][j] + dp[i][j]
                S_curr[j] = (S_prev[j] + dp_curr[j]) % MOD;
            }
            dp_prev = dp_curr;
            S_prev = S_curr;
        }

        return dp_prev[k];
    }
};
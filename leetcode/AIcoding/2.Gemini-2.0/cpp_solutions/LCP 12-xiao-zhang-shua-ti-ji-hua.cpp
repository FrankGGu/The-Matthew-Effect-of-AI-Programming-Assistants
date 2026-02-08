#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int minDifficulty(vector<int>& jobDifficulty, int d) {
        int n = jobDifficulty.size();
        if (n < d) return -1;

        vector<vector<int>> dp(d, vector<int>(n, 10000000));

        int max_diff = 0;
        for (int i = 0; i <= n - d; ++i) {
            max_diff = max(max_diff, jobDifficulty[i]);
            dp[0][i] = max_diff;
        }

        for (int i = 1; i < d; ++i) {
            for (int j = i; j <= n - d + i; ++j) {
                int max_diff = 0;
                for (int k = j; k >= i; --k) {
                    max_diff = max(max_diff, jobDifficulty[k]);
                    dp[i][j] = min(dp[i][j], dp[i - 1][k - 1] + max_diff);
                }
            }
        }

        return dp[d - 1][n - 1];
    }
};
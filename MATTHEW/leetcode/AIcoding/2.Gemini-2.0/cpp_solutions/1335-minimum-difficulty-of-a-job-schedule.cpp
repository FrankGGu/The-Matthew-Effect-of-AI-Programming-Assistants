#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minDifficulty(vector<int>& jobDifficulty, int d) {
        int n = jobDifficulty.size();
        if (n < d) {
            return -1;
        }

        vector<vector<int>> dp(d + 1, vector<int>(n + 1, 1e9));
        dp[0][0] = 0;

        for (int i = 1; i <= d; ++i) {
            for (int j = i; j <= n; ++j) {
                int max_difficulty = 0;
                for (int k = j; k >= i; --k) {
                    max_difficulty = max(max_difficulty, jobDifficulty[k - 1]);
                    dp[i][j] = min(dp[i][j], dp[i - 1][k - 1] + max_difficulty);
                }
            }
        }

        return dp[d][n];
    }
};
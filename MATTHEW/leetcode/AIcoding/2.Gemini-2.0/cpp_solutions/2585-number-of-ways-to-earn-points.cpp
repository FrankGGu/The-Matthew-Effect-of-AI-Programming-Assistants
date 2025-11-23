#include <vector>

using namespace std;

class Solution {
public:
    int numberOfWays(int k, int target) {
        vector<vector<int>> dp(k + 1, vector<int>(target + 1, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= k; ++i) {
            for (int j = 0; j <= target; ++j) {
                for (int x = 0; x <= i; ++x) {
                    if (j - x >= 0) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][j - x]) % 1000000007;
                    }
                }
            }
        }

        return dp[k][target];
    }
};
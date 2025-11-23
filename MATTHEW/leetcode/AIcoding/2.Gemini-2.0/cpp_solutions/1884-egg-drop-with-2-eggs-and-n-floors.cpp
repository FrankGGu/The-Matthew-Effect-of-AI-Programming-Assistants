#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int twoEggDrop(int n) {
        vector<vector<int>> dp(3, vector<int>(n + 1, 0));

        for (int j = 1; j <= n; ++j) {
            dp[1][j] = j;
        }

        for (int i = 1; i <= 2; ++i) {
            dp[i][1] = 1;
        }

        for (int i = 2; i <= 2; ++i) {
            for (int j = 2; j <= n; ++j) {
                dp[i][j] = INT_MAX;
                for (int k = 1; k <= j; ++k) {
                    dp[i][j] = min(dp[i][j], 1 + max(dp[i - 1][k - 1], dp[i][j - k]));
                }
            }
        }

        return dp[2][n];
    }
};
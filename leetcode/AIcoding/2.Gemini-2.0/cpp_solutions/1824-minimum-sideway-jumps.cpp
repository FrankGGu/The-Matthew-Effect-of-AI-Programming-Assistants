#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSideJumps(vector<int>& obstacles) {
        int n = obstacles.size();
        vector<vector<int>> dp(3, vector<int>(n, 1e9));
        dp[1][0] = 0;
        dp[0][0] = 1;
        dp[2][0] = 1;

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < 3; ++j) {
                if (obstacles[i] != j + 1) {
                    dp[j][i] = dp[j][i - 1];
                }
            }

            for (int j = 0; j < 3; ++j) {
                if (obstacles[i] != j + 1) {
                    for (int k = 0; k < 3; ++k) {
                        if (j != k && obstacles[i] != k + 1) {
                            dp[j][i] = min(dp[j][i], dp[k][i] + 1);
                        }
                    }
                }
            }
        }

        return min({dp[0][n - 1], dp[1][n - 1], dp[2][n - 1]});
    }
};
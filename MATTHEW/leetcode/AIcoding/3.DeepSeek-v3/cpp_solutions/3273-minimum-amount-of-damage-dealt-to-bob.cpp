#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumDamageDealtToBob(vector<int>& aliceArrows, int k) {
        int n = aliceArrows.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                dp[i][j] = dp[i - 1][j];
                if (j > 0) {
                    int arrows = min(aliceArrows[i - 1] + 1, j);
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - arrows] + (i - 1));
                }
            }
        }

        return dp[n][k];
    }
};
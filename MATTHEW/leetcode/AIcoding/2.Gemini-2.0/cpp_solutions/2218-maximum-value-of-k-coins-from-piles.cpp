#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxValueOfCoins(vector<vector<int>>& piles, int k) {
        int n = piles.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                dp[i][j] = dp[i - 1][j];
                int currentSum = 0;
                for (int x = 1; x <= min((int)piles[i - 1].size(), j); ++x) {
                    currentSum += piles[i - 1][x - 1];
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - x] + currentSum);
                }
            }
        }

        return dp[n][k];
    }
};
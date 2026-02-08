#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int maxValueOfCoins(vector<vector<int>>& piles, int k) {
        int n = piles.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int coins = 0; coins <= k; ++coins) {
                dp[i][coins] = dp[i - 1][coins];
                int current_sum = 0;
                for (int x = 1; x <= min((int)piles[i - 1].size(), coins); ++x) {
                    current_sum += piles[i - 1][x - 1];
                    dp[i][coins] = max(dp[i][coins], current_sum + dp[i - 1][coins - x]);
                }
            }
        }

        return dp[n][k];
    }
};
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minDistance(vector<int>& houses, int k) {
        int n = houses.size();
        sort(houses.begin(), houses.end());

        vector<vector<int>> cost(n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int median = houses[(i + j) / 2];
                for (int l = i; l <= j; ++l) {
                    cost[i][j] += abs(houses[l] - median);
                }
            }
        }

        vector<vector<int>> dp(n, vector<int>(k + 1, INT_MAX));
        for (int i = 0; i < n; ++i) {
            dp[i][1] = cost[0][i];
        }

        for (int j = 2; j <= k; ++j) {
            for (int i = j - 1; i < n; ++i) {
                for (int l = j - 2; l < i; ++l) {
                    if (dp[l][j - 1] != INT_MAX) {
                        dp[i][j] = min(dp[i][j], dp[l][j - 1] + cost[l + 1][i]);
                    }
                }
            }
        }

        return dp[n - 1][k];
    }
};
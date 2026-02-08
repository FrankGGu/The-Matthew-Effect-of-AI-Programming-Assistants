#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minTravelTime(vector<int>& stations, int K) {
        int n = stations.size();
        if (n == 0) return 0;

        vector<vector<int>> dp(n, vector<int>(K + 1, INT_MAX));
        vector<vector<int>> cost(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int mid = (i + j) / 2;
                for (int k = i; k <= j; ++k) {
                    cost[i][j] += abs(stations[k] - stations[mid]);
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            dp[i][1] = cost[0][i];
        }

        for (int k = 2; k <= K; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < i; ++j) {
                    if (dp[j][k - 1] != INT_MAX) {
                        dp[i][k] = min(dp[i][k], dp[j][k - 1] + cost[j + 1][i]);
                    }
                }
            }
        }

        return dp[n - 1][K];
    }
};
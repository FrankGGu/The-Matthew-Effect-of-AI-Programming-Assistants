#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minDistance(int n, vector<int>& stations, vector<int>& bridges) {
        sort(stations.begin(), stations.end());
        sort(bridges.begin(), bridges.end());

        int m = bridges.size();
        int k = stations.size();

        vector<int> dp(k + 1, 0);
        for (int i = 1; i <= k; ++i) {
            dp[i] = dp[i - 1] + abs(stations[i - 1] - bridges[0]);
        }

        for (int j = 1; j < m; ++j) {
            vector<int> new_dp(k + 1, 0);
            new_dp[0] = dp[0] + abs(stations[0] - bridges[j]);
            for (int i = 1; i <= k; ++i) {
                new_dp[i] = min(new_dp[i - 1], dp[i - 1]) + abs(stations[i - 1] - bridges[j]);
            }
            dp = new_dp;
        }

        return dp[k];
    }
};
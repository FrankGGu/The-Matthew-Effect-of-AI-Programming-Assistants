#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxPoints(vector<int>& points) {
        int m = points.size();
        int n = points[0].size();
        vector<long long> dp = points[0];

        for (int i = 1; i < m; ++i) {
            vector<long long> new_dp(n, 0);
            long long max_val = 0;
            for (int j = 0; j < n; ++j) {
                max_val = max(max_val, dp[j] - j);
                new_dp[j] = max_val + j + points[i][j];
            }
            max_val = 0;
            for (int j = n - 1; j >= 0; --j) {
                max_val = max(max_val, dp[j] + j);
                new_dp[j] = max(new_dp[j], max_val - j + points[i][j]);
            }
            dp = new_dp;
        }
        return *max_element(dp.begin(), dp.end());
    }
};
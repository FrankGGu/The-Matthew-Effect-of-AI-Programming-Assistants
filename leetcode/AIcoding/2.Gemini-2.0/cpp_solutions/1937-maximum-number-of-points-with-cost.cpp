#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxPoints(vector<vector<int>>& points) {
        int m = points.size();
        int n = points[0].size();
        vector<long long> dp(n);
        for (int j = 0; j < n; ++j) {
            dp[j] = points[0][j];
        }

        for (int i = 1; i < m; ++i) {
            vector<long long> left(n);
            vector<long long> right(n);
            left[0] = dp[0];
            for (int j = 1; j < n; ++j) {
                left[j] = max(left[j - 1] - 1, dp[j]);
            }
            right[n - 1] = dp[n - 1];
            for (int j = n - 2; j >= 0; --j) {
                right[j] = max(right[j + 1] - 1, dp[j]);
            }

            for (int j = 0; j < n; ++j) {
                dp[j] = max(left[j], right[j]) + points[i][j];
            }
        }

        long long ans = 0;
        for (int j = 0; j < n; ++j) {
            ans = max(ans, dp[j]);
        }
        return ans;
    }
};
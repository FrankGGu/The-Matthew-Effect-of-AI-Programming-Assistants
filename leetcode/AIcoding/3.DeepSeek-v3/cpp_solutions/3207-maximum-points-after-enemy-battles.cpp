#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxPoints(vector<vector<int>>& points) {
        int m = points.size();
        if (m == 0) return 0;
        int n = points[0].size();
        vector<long long> dp(n, 0);

        for (int i = 0; i < m; ++i) {
            vector<long long> left(n, 0);
            vector<long long> right(n, 0);
            vector<long long> current(n, 0);

            left[0] = dp[0];
            for (int j = 1; j < n; ++j) {
                left[j] = max(left[j-1] - 1, dp[j]);
            }

            right[n-1] = dp[n-1];
            for (int j = n-2; j >= 0; --j) {
                right[j] = max(right[j+1] - 1, dp[j]);
            }

            for (int j = 0; j < n; ++j) {
                current[j] = points[i][j] + max(left[j], right[j]);
            }

            dp = current;
        }

        return *max_element(dp.begin(), dp.end());
    }
};
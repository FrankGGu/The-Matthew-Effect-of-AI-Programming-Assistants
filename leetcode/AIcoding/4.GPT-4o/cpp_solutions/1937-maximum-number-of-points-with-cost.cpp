class Solution {
public:
    int maxPoints(vector<vector<int>>& points) {
        int m = points.size(), n = points[0].size();
        vector<int> dp(n, 0);

        for (int i = 0; i < m; ++i) {
            vector<int> new_dp(n, 0);
            int left_max = 0, right_max = 0;

            for (int j = 0; j < n; ++j) {
                left_max = max(left_max, dp[j] + points[i][j]);
                new_dp[j] = left_max;
            }

            for (int j = n - 1; j >= 0; --j) {
                right_max = max(right_max, dp[j] - points[i][j]);
                new_dp[j] = max(new_dp[j], right_max + points[i][j]);
            }

            dp = new_dp;
        }

        return *max_element(dp.begin(), dp.end());
    }
};
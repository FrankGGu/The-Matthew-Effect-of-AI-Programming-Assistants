class Solution {
public:
    int maxPoints(vector<vector<int>>& points) {
        int n = points.size();
        vector<int> dp(n, 0);
        dp[0] = points[0][0];

        for (int i = 1; i < n; ++i) {
            dp[i] = dp[i - 1];
            for (int j = 0; j < i; ++j) {
                if (points[j][1] < points[i][0]) {
                    dp[i] = max(dp[i], dp[j] + points[i][0]);
                }
            }
            dp[i] = max(dp[i], points[i][0]);
        }

        return *max_element(dp.begin(), dp.end());
    }
};
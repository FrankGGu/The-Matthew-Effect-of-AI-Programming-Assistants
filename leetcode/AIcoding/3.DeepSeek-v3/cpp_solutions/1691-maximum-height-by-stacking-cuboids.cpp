class Solution {
public:
    int maxHeight(vector<vector<int>>& cuboids) {
        for (auto& cuboid : cuboids) {
            sort(cuboid.begin(), cuboid.end());
        }
        sort(cuboids.begin(), cuboids.end(), [](const vector<int>& a, const vector<int>& b) {
            if (a[0] != b[0]) return a[0] > b[0];
            if (a[1] != b[1]) return a[1] > b[1];
            return a[2] > b[2];
        });
        int n = cuboids.size();
        vector<int> dp(n);
        int res = 0;
        for (int i = 0; i < n; ++i) {
            dp[i] = cuboids[i][2];
            for (int j = 0; j < i; ++j) {
                if (cuboids[j][0] >= cuboids[i][0] && cuboids[j][1] >= cuboids[i][1] && cuboids[j][2] >= cuboids[i][2]) {
                    dp[i] = max(dp[i], dp[j] + cuboids[i][2]);
                }
            }
            res = max(res, dp[i]);
        }
        return res;
    }
};
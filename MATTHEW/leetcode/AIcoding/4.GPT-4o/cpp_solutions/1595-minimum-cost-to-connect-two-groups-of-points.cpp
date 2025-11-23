class Solution {
public:
    int connectTwoGroups(vector<vector<int>>& cost) {
        int n = cost.size(), m = cost[0].size();
        vector<int> dp(1 << m, INT_MAX);
        dp[0] = 0;

        for (int i = 0; i < n; ++i) {
            vector<int> new_dp(1 << m, INT_MAX);
            for (int j = 0; j < (1 << m); ++j) {
                if (dp[j] == INT_MAX) continue;
                for (int k = 0; k < m; ++k) {
                    new_dp[j | (1 << k)] = min(new_dp[j | (1 << k)], dp[j] + cost[i][k]);
                }
            }
            dp = move(new_dp);
        }

        int ans = INT_MAX;
        for (int j = 0; j < (1 << m); ++j) {
            int sum = dp[j];
            for (int k = 0; k < m; ++k) {
                if (!(j & (1 << k))) {
                    int min_cost = INT_MAX;
                    for (int i = 0; i < n; ++i) {
                        min_cost = min(min_cost, cost[i][k]);
                    }
                    sum += min_cost;
                }
            }
            ans = min(ans, sum);
        }

        return ans;
    }
};
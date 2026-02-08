class Solution {
public:
    long long minimizeTotalPrice(int n, vector<vector<int>>& trips) {
        vector<long long> dp(n + 1, 0);
        vector<long long> total(n + 1, 0);

        for (auto& trip : trips) {
            int start = trip[0], end = trip[1];
            total[start] += 1;
            if (end + 1 <= n) total[end + 1] -= 1;
        }

        for (int i = 1; i <= n; ++i) {
            total[i] += total[i - 1];
        }

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + total[i];
            if (i >= 2) {
                dp[i] = min(dp[i], dp[i - 2] + (total[i - 1] + total[i]));
            }
        }

        return dp[n];
    }
};
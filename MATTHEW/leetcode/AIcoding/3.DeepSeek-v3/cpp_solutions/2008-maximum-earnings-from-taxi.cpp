class Solution {
public:
    long long maxTaxiEarnings(int n, vector<vector<int>>& rides) {
        sort(rides.begin(), rides.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        vector<long long> dp(n + 1, 0);
        int idx = 0;
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1];
            while (idx < rides.size() && rides[idx][1] == i) {
                int start = rides[idx][0];
                int end = rides[idx][1];
                int tip = rides[idx][2];
                long long earn = end - start + tip;
                dp[i] = max(dp[i], dp[start] + earn);
                ++idx;
            }
        }
        return dp[n];
    }
};
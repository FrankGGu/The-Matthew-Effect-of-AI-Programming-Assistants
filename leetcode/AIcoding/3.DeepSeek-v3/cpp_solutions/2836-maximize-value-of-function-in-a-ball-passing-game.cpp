class Solution {
public:
    long long getMaxFunctionValue(vector<int>& receiver, long long k) {
        int n = receiver.size();
        int m = 64 - __builtin_clzll(k);
        vector<vector<pair<int, long long>>> dp(m, vector<pair<int, long long>>(n));

        for (int i = 0; i < n; ++i) {
            dp[0][i] = {receiver[i], receiver[i]};
        }

        for (int j = 1; j < m; ++j) {
            for (int i = 0; i < n; ++i) {
                int mid = dp[j-1][i].first;
                long long sum = dp[j-1][i].second;
                dp[j][i] = {dp[j-1][mid].first, sum + dp[j-1][mid].second};
            }
        }

        long long res = 0;
        for (int i = 0; i < n; ++i) {
            long long current_sum = i;
            int pos = i;
            for (int j = 0; j < m; ++j) {
                if ((k >> j) & 1) {
                    current_sum += dp[j][pos].second;
                    pos = dp[j][pos].first;
                }
            }
            res = max(res, current_sum);
        }
        return res;
    }
};
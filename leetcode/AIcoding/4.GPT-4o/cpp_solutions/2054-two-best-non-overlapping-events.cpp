class Solution {
public:
    int maxTwoEvents(vector<vector<int>>& events) {
        sort(events.begin(), events.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        int n = events.size();
        vector<int> dp(n);

        for (int i = 0; i < n; ++i) {
            dp[i] = events[i][2];
        }

        int res = 0;
        for (int i = 0; i < n; ++i) {
            res = max(res, dp[i]);
            for (int j = i + 1; j < n; ++j) {
                if (events[i][1] < events[j][0]) {
                    dp[j] = max(dp[j], dp[i] + events[j][2]);
                }
            }
        }

        return res;
    }
};
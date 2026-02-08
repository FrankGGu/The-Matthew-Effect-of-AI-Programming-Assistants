class Solution {
public:
    int maxValue(vector<vector<int>>& events, int k) {
        int n = events.size();
        vector<vector<int>> dp(k + 1, vector<int>(n + 1, 0));

        sort(events.begin(), events.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        for (int i = 1; i <= k; ++i) {
            for (int j = 1; j <= n; ++j) {
                dp[i][j] = dp[i][j - 1];
                int l = 0, r = j - 1;
                while (l < r) {
                    int mid = l + (r - l) / 2;
                    if (events[mid][1] < events[j - 1][0]) {
                        l = mid + 1;
                    } else {
                        r = mid;
                    }
                }
                if (events[l][1] < events[j - 1][0]) {
                    dp[i][j] = max(dp[i][j], dp[i - 1][l + 1] + events[j - 1][2]);
                }
            }
        }

        return dp[k][n];
    }
};
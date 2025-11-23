class Solution {
public:
    int findRotateSteps(string ring, string key) {
        int n = ring.size(), m = key.size();
        vector<vector<int>> dp(m + 1, vector<int>(n, INT_MAX));
        vector<vector<int>> pos(26);

        for (int i = 0; i < n; ++i) {
            pos[ring[i] - 'a'].push_back(i);
        }

        for (int i = 0; i < n; ++i) {
            dp[0][i] = 0;
        }

        for (int i = 1; i <= m; ++i) {
            for (int j : pos[key[i - 1] - 'a']) {
                for (int k = 0; k < n; ++k) {
                    if (dp[i - 1][k] != INT_MAX) {
                        int steps = abs(j - k);
                        steps = min(steps, n - steps);
                        dp[i][j] = min(dp[i][j], dp[i - 1][k] + steps + 1);
                    }
                }
            }
        }

        return *min_element(dp[m].begin(), dp[m].end());
    }
};
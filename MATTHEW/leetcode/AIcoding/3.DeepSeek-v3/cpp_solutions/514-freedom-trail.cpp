class Solution {
public:
    int findRotateSteps(string ring, string key) {
        int n = ring.size(), m = key.size();
        unordered_map<char, vector<int>> pos;
        for (int i = 0; i < n; ++i) {
            pos[ring[i]].push_back(i);
        }
        vector<vector<int>> dp(m, vector<int>(n, INT_MAX));
        for (int i : pos[key[0]]) {
            dp[0][i] = min(i, n - i) + 1;
        }
        for (int i = 1; i < m; ++i) {
            for (int j : pos[key[i]]) {
                for (int k : pos[key[i - 1]]) {
                    int diff = abs(j - k);
                    int step = min(diff, n - diff);
                    dp[i][j] = min(dp[i][j], dp[i - 1][k] + step + 1);
                }
            }
        }
        return *min_element(dp[m - 1].begin(), dp[m - 1].end());
    }
};
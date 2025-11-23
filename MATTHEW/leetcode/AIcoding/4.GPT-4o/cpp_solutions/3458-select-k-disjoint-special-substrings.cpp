class Solution {
public:
    int maxSpecialSubstring(string s, int k) {
        int n = s.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 0));
        unordered_map<char, int> lastPos;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= k; ++j) {
                dp[i][j] = dp[i - 1][j];
                if (lastPos.find(s[i - 1]) == lastPos.end() || lastPos[s[i - 1]] < i - 1) {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - 1] + 1);
                }
            }
            lastPos[s[i - 1]] = i - 1;
        }

        return dp[n][k];
    }
};
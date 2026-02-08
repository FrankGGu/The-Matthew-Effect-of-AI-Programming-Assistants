class Solution {
public:
    int maximumScore(string s, vector<int>& scores) {
        int maxScore = 0, n = s.size();
        vector<int> dp(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            dp[i + 1] = max(dp[i + 1], dp[i]);
            for (int j = i; j < n; ++j) {
                if (s[i] == s[j]) {
                    dp[j + 1] = max(dp[j + 1], dp[i] + scores[j]);
                }
            }
            maxScore = max(maxScore, dp[i + 1]);
        }

        return maxScore;
    }
};
class Solution {
public:
    int minExtraChar(string s, vector<string>& dictionary) {
        unordered_set<string> dict(dictionary.begin(), dictionary.end());
        vector<int> dp(s.size() + 1, 0);

        for (int i = 1; i <= s.size(); ++i) {
            dp[i] = dp[i - 1] + 1;
            for (int j = 0; j < i; ++j) {
                string sub = s.substr(j, i - j);
                if (dict.count(sub)) {
                    dp[i] = min(dp[i], dp[j]);
                }
            }
        }

        return dp[s.size()];
    }
};
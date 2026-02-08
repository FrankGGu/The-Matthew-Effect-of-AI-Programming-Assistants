class Solution {
public:
    int minExtraChar(string s, vector<string>& dictionary) {
        unordered_set<string> dict(dictionary.begin(), dictionary.end());
        int n = s.size();
        vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + 1;
            for (int j = i; j >= 1; --j) {
                string substr = s.substr(j - 1, i - j + 1);
                if (dict.find(substr) != dict.end()) {
                    dp[i] = min(dp[i], dp[j - 1]);
                }
            }
        }

        return dp[n];
    }
};
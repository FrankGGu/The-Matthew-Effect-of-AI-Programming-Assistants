class Solution {
public:
    vector<string> getWordsInLongestSubsequence(int n, vector<string>& words, vector<int>& groups) {
        vector<vector<string>> dp(n);
        vector<int> len(n, 1);
        int max_len = 1;
        int max_idx = 0;

        for (int i = 0; i < n; ++i) {
            dp[i].push_back(words[i]);
            for (int j = 0; j < i; ++j) {
                if (groups[i] != groups[j] && words[i].size() == words[j].size()) {
                    int diff = 0;
                    for (int k = 0; k < words[i].size(); ++k) {
                        if (words[i][k] != words[j][k]) {
                            diff++;
                            if (diff > 1) break;
                        }
                    }
                    if (diff == 1) {
                        if (len[j] + 1 > len[i]) {
                            len[i] = len[j] + 1;
                            dp[i] = dp[j];
                            dp[i].push_back(words[i]);
                        }
                    }
                }
            }
            if (len[i] > max_len) {
                max_len = len[i];
                max_idx = i;
            }
        }

        return dp[max_idx];
    }
};
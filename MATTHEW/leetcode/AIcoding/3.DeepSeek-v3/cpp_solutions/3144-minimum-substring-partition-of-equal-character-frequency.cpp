class Solution {
public:
    int minimumSubstringsInPartition(string s) {
        int n = s.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            vector<int> freq(26, 0);
            for (int j = i; j >= 1; --j) {
                freq[s[j - 1] - 'a']++;
                bool valid = true;
                int count = -1;
                for (int k = 0; k < 26; ++k) {
                    if (freq[k] > 0) {
                        if (count == -1) {
                            count = freq[k];
                        } else if (freq[k] != count) {
                            valid = false;
                            break;
                        }
                    }
                }
                if (valid && dp[j - 1] != INT_MAX) {
                    dp[i] = min(dp[i], dp[j - 1] + 1);
                }
            }
        }

        return dp[n];
    }
};
class Solution {
public:
    int minimumBeautifulSubstrings(string s) {
        int n = s.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;
        unordered_set<string> power5 = {"1", "101", "11001", "1111101", "1001110001", "110000110101", "11110100001001"};

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (dp[j] != INT_MAX && power5.count(s.substr(j, i - j))) {
                    if (dp[i] > dp[j] + 1) {
                        dp[i] = dp[j] + 1;
                    }
                }
            }
        }

        return dp[n] == INT_MAX ? -1 : dp[n];
    }
};
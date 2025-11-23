class Solution {
public:
    int minOperations(string s1, string s2, int x) {
        vector<int> diff;
        for (int i = 0; i < s1.size(); ++i) {
            if (s1[i] != s2[i]) {
                diff.push_back(i);
            }
        }
        if (diff.size() % 2 != 0) {
            return -1;
        }
        int n = diff.size();
        if (n == 0) {
            return 0;
        }
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;
        for (int i = 1; i <= n; ++i) {
            if (i % 2 == 0) {
                dp[i] = dp[i - 1];
            } else {
                if (i >= 2) {
                    dp[i] = min(dp[i - 1] + x, dp[i - 2] + diff[i - 1] - diff[i - 2]);
                } else {
                    dp[i] = dp[i - 1] + x;
                }
            }
        }
        return dp[n];
    }
};
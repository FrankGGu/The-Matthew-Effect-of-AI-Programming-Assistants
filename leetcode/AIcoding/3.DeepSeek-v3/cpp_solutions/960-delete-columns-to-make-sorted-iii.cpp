class Solution {
public:
    int minDeletionSize(vector<string>& strs) {
        int n = strs.size();
        if (n == 0) return 0;
        int m = strs[0].size();
        vector<int> dp(m, 1);
        int max_len = 1;

        for (int j = 1; j < m; ++j) {
            for (int i = 0; i < j; ++i) {
                bool valid = true;
                for (const string& s : strs) {
                    if (s[i] > s[j]) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    dp[j] = max(dp[j], dp[i] + 1);
                }
            }
            max_len = max(max_len, dp[j]);
        }

        return m - max_len;
    }
};
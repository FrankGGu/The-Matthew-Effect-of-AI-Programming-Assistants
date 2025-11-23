class Solution {
public:
    int longestIdealString(string s, int k) {
        int dp[26] = {0};
        int res = 0;
        for (char c : s) {
            int curr = c - 'a';
            int max_len = 0;
            for (int i = max(0, curr - k); i <= min(25, curr + k); ++i) {
                max_len = max(max_len, dp[i]);
            }
            dp[curr] = max_len + 1;
            res = max(res, dp[curr]);
        }
        return res;
    }
};
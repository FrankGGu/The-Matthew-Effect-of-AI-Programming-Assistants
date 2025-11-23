class Solution {
public:
    int maxPalindromes(string s, int k) {
        int n = s.size();
        vector<bool> dp(n, false);
        vector<int> maxPalin(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            for (int len = 1; i - len + 1 >= 0 && i + len < n; ++len) {
                if (s[i - len + 1] == s[i + len]) {
                    dp[i - len + 1] = dp[i + len] = true;
                } else {
                    break;
                }
            }
            for (int len = 0; i - len >= 0 && i + len < n; ++len) {
                if (s[i - len] == s[i + len]) {
                    dp[i - len] = dp[i + len] = true;
                } else {
                    break;
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            maxPalin[i + 1] = maxPalin[i];
            if (dp[i]) {
                for (int j = 0; j <= i; ++j) {
                    if (i - j + 1 >= k) {
                        maxPalin[i + 1] = max(maxPalin[i + 1], maxPalin[j] + 1);
                    }
                }
            }
        }

        return maxPalin[n];
    }
};
class Solution {
public:
    int minimumBeautifulSubstrings(string s) {
        int n = s.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            int num = 0;
            for (int j = i; j >= 1 && j >= i - 20; --j) {
                num = (num << 1) + (s[j - 1] - '0');
                if (isBeautiful(num)) {
                    dp[i] = min(dp[i], dp[j - 1] + 1);
                }
            }
        }

        return dp[n] == INT_MAX ? -1 : dp[n];
    }

    bool isBeautiful(int num) {
        return num && (num & (num - 1)) == 0;
    }
};
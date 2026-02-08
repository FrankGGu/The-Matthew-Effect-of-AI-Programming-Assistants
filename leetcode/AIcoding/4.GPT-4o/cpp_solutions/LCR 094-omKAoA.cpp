class Solution {
public:
    int minCut(string s) {
        int n = s.size();
        vector<int> dp(n + 1);
        vector<vector<bool>> isPalindrome(n, vector<bool>(n, false));

        for (int i = 0; i <= n; i++) {
            dp[i] = n - i; // Maximum cuts
        }

        for (int i = n - 1; i >= 0; i--) {
            for (int j = i; j < n; j++) {
                if (s[i] == s[j] && (j - i < 2 || isPalindrome[i + 1][j - 1])) {
                    isPalindrome[i][j] = true;
                    dp[i] = min(dp[i], dp[j + 1] + 1);
                }
            }
        }

        return dp[0] - 1;
    }
};
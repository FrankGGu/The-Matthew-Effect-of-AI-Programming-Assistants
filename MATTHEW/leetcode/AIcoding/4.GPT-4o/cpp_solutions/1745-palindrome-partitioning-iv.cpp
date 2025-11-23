class Solution {
public:
    bool checkPartitioning(string s) {
        int n = s.size();
        vector<vector<bool>> dp(n, vector<bool>(n, false));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = true;
        }

        for (int length = 2; length <= n; ++length) {
            for (int start = 0; start <= n - length; ++start) {
                int end = start + length - 1;
                if (s[start] == s[end]) {
                    dp[start][end] = length == 2 || dp[start + 1][end - 1];
                }
            }
        }

        for (int i = 0; i < n - 2; ++i) {
            if (dp[0][i]) {
                for (int j = i + 1; j < n - 1; ++j) {
                    if (dp[i + 1][j]) {
                        if (dp[j + 1][n - 1]) {
                            return true;
                        }
                    }
                }
            }
        }

        return false;
    }
};
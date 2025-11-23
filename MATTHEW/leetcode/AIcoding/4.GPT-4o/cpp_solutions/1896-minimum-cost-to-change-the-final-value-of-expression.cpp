class Solution {
public:
    int minOperations(string expression) {
        int n = expression.size();
        vector<vector<int>> dp(n, vector<int>(n, INT_MAX));
        vector<vector<int>> dp2(n, vector<int>(n, INT_MAX));

        for (int i = 0; i < n; i += 2) {
            dp[i][i] = expression[i] - '0';
            dp2[i][i] = 1 - (expression[i] - '0');
        }

        for (int len = 3; len <= n; len += 2) {
            for (int i = 0; i < n - len + 1; i += 2) {
                int j = i + len - 1;
                for (int k = i + 1; k < j; k += 2) {
                    if (expression[k] == '&') {
                        dp[i][j] = min(dp[i][j], dp[i][k - 1] & dp[k + 1][j]);
                        dp2[i][j] = min(dp2[i][j], dp2[i][k - 1] & dp2[k + 1][j] + 1);
                    } else if (expression[k] == '|') {
                        dp[i][j] = min(dp[i][j], dp[i][k - 1] | dp[k + 1][j]);
                        dp2[i][j] = min(dp2[i][j], dp2[i][k - 1] | dp2[k + 1][j] + 1);
                    } else if (expression[k] == '^') {
                        dp[i][j] = min(dp[i][j], dp[i][k - 1] ^ dp[k + 1][j]);
                        dp2[i][j] = min(dp2[i][j], dp2[i][k - 1] ^ dp2[k + 1][j] + 1);
                    }
                }
            }
        }
        return min(dp[0][n - 1], dp2[0][n - 1]);
    }
};
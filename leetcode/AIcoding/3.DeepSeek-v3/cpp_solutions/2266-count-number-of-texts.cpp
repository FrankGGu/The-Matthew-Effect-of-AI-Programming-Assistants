class Solution {
public:
    int countTexts(string pressedKeys) {
        const int MOD = 1e9 + 7;
        int n = pressedKeys.size();
        vector<long long> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1];
            if (i >= 2 && pressedKeys[i - 1] == pressedKeys[i - 2]) {
                dp[i] = (dp[i] + dp[i - 2]) % MOD;
                if (i >= 3 && pressedKeys[i - 1] == pressedKeys[i - 3]) {
                    dp[i] = (dp[i] + dp[i - 3]) % MOD;
                    if ((pressedKeys[i - 1] == '7' || pressedKeys[i - 1] == '9') && i >= 4 && pressedKeys[i - 1] == pressedKeys[i - 4]) {
                        dp[i] = (dp[i] + dp[i - 4]) % MOD;
                    }
                }
            }
        }

        return dp[n];
    }
};
class Solution {
public:
    int countTexts(string pressedKeys) {
        int n = pressedKeys.size();
        vector<int> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 1; i <= n; ++i) {
            int count = 1;
            dp[i] = dp[i - 1];
            while (i - count >= 0 && pressedKeys[i - 1] == pressedKeys[i - count]) {
                if ((pressedKeys[i - 1] == '7' || pressedKeys[i - 1] == '9') && count <= 4) {
                    dp[i] = (dp[i] + dp[i - count]) % 1000000007;
                } else if (count <= 3) {
                    dp[i] = (dp[i] + dp[i - count]) % 1000000007;
                }
                count++;
            }
        }

        return dp[n];
    }
};
class Solution {
public:
    int minTimeToRevert(string current, string target, int time) {
        int n = current.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j <= i; ++j) {
                if (current[i] == target[j]) {
                    dp[i + 1] = min(dp[i + 1], dp[j] + time);
                }
            }
            dp[i + 1] = min(dp[i + 1], dp[i] + time);
        }

        return dp[n];
    }
};
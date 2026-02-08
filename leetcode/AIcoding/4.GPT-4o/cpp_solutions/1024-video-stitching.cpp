class Solution {
public:
    int videoStitching(vector<vector<int>>& clips, int T) {
        vector<int> dp(T + 1, INT_MAX);
        dp[0] = 0;

        for (const auto& clip : clips) {
            int start = clip[0], end = clip[1];
            for (int j = min(T, end); j >= start; --j) {
                if (dp[j - start] != INT_MAX) {
                    dp[j] = min(dp[j], dp[j - start] + 1);
                }
            }
        }

        return dp[T] == INT_MAX ? -1 : dp[T];
    }
};
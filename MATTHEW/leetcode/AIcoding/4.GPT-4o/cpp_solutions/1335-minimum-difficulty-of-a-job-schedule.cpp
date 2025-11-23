class Solution {
public:
    int minDifficulty(vector<int>& jobDifficulty, int d) {
        int n = jobDifficulty.size();
        if (n < d) return -1;

        vector<vector<int>> dp(d + 1, vector<int>(n + 1, INT_MAX));
        dp[0][0] = 0;

        for (int day = 1; day <= d; ++day) {
            for (int i = day; i <= n; ++i) {
                int maxDifficulty = 0;
                for (int j = i; j >= day; --j) {
                    maxDifficulty = max(maxDifficulty, jobDifficulty[j - 1]);
                    dp[day][i] = min(dp[day][i], dp[day - 1][j - 1] + maxDifficulty);
                }
            }
        }

        return dp[d][n];
    }
};
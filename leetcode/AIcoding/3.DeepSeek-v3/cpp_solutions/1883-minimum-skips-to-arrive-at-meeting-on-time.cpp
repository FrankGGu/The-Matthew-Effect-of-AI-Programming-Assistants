class Solution {
public:
    int minSkips(vector<int>& dist, int speed, int hoursBefore) {
        int n = dist.size();
        vector<vector<double>> dp(n + 1, vector<double>(n + 1, 1e20));
        dp[0][0] = 0;

        for (int i = 1; i <= n; ++i) {
            double t = (double)dist[i - 1] / speed;
            for (int j = 0; j <= i; ++j) {
                if (j < i) {
                    dp[i][j] = min(dp[i][j], ceil(dp[i - 1][j] - 1e-9) + t);
                }
                if (j > 0) {
                    dp[i][j] = min(dp[i][j], dp[i - 1][j - 1] + t);
                }
            }
        }

        for (int j = 0; j <= n; ++j) {
            if (dp[n][j] <= hoursBefore + 1e-9) {
                return j;
            }
        }

        return -1;
    }
};
class Solution {
public:
    double new21Game(int n, int k, int maxPts) {
        if (k == 0 || n >= k) return 1.0;
        vector<double> dp(n + 1, 0.0);
        dp[0] = 1.0;
        double sum = dp[0];
        for (int i = 1; i <= n; ++i) {
            dp[i] = sum / maxPts;
            if (i < k) sum += dp[i];
            if (i - maxPts >= 0) sum -= dp[i - maxPts];
        }
        double result = 0.0;
        for (int i = k; i <= n; ++i) {
            result += dp[i];
        }
        return result;
    }
};
class Solution {
public:
    double soupServings(int N) {
        if (N > 5000) return 1.0;
        vector<vector<double>> dp(N + 1, vector<double>(N + 1, -1));
        return helper(N, N, dp);
    }

    double helper(int a, int b, vector<vector<double>>& dp) {
        if (a <= 0 && b <= 0) return 0.5;
        if (a <= 0) return 1.0;
        if (b <= 0) return 0.0;
        if (dp[a][b] != -1) return dp[a][b];

        dp[a][b] = 0.25 * (helper(a - 100, b) + helper(a - 75, b - 25) + 
                          helper(a - 50, b - 50) + helper(a - 25, b - 75));
        return dp[a][b];
    }
};
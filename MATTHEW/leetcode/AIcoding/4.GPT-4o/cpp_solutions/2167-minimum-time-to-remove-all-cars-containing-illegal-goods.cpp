class Solution {
public:
    int minimumTime(string cars) {
        int n = cars.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            if (cars[i - 1] == '0') {
                dp[i] = min(dp[i], dp[i - 1]);
            }
            if (i >= 2 && cars[i - 1] == '1' && cars[i - 2] == '1') {
                dp[i] = min(dp[i], dp[i - 2] + 2);
            }
            if (i >= 3 && cars[i - 1] == '1' && cars[i - 2] == '1' && cars[i - 3] == '1') {
                dp[i] = min(dp[i], dp[i - 3] + 3);
            }
            if (i >= 4 && cars[i - 1] == '1' && cars[i - 2] == '1' && cars[i - 3] == '1' && cars[i - 4] == '1') {
                dp[i] = min(dp[i], dp[i - 4] + 4);
            }
        }

        return dp[n];
    }
};
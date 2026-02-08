class Solution {
public:
    int minimumLevels(vector<int>& arr) {
        int n = arr.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                if (arr[i] < j) {
                    dp[j] = min(dp[j], dp[j - 1] + 1);
                }
            }
        }

        return dp[n] == INT_MAX ? -1 : dp[n];
    }
};
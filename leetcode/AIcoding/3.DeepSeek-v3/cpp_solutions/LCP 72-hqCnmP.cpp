using namespace std;

class Solution {
public:
    int minEnegySupplies(vector<int>& supplies) {
        int n = supplies.size();
        vector<int> prefix(n+1, 0);
        for (int i = 0; i < n; i++) {
            prefix[i+1] = prefix[i] + supplies[i];
        }

        vector<vector<int>> dp(n, vector<int>(n, INT_MAX));
        for (int i = 0; i < n; i++) {
            dp[i][i] = 0;
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                int total = prefix[j+1] - prefix[i];
                for (int k = i; k < j; k++) {
                    dp[i][j] = min(dp[i][j], dp[i][k] + dp[k+1][j] + total);
                }
            }
        }

        return dp[0][n-1];
    }
};
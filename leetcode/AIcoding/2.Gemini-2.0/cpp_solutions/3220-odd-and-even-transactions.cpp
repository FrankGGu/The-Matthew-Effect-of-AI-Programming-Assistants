#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int solve(vector<int>& transactions) {
        int n = transactions.size();
        if (n == 0) return 0;

        vector<vector<int>> dp(n + 1, vector<int>(2, 0));

        for (int i = 1; i <= n; ++i) {
            if (transactions[i - 1] % 2 == 0) {
                dp[i][0] = max(dp[i - 1][0], dp[i - 1][1] + transactions[i - 1]);
                dp[i][1] = dp[i - 1][1];
            } else {
                dp[i][0] = dp[i - 1][0];
                dp[i][1] = max(dp[i - 1][1], dp[i - 1][0] + transactions[i - 1]);
            }
        }

        return dp[n][0];
    }
};
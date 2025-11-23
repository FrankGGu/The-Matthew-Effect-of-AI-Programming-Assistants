#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int mctFromLeafValues(vector<int>& arr) {
        int n = arr.size();
        vector<vector<int>> dp(n + 1, vector<int>(n + 1, INT_MAX));
        vector<vector<int>> max_val(n + 1, vector<int>(n + 1, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = 0;
            max_val[i][i] = arr[i];
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                for (int k = i; k < j; ++k) {
                    dp[i][j] = min(dp[i][j], dp[i][k] + dp[k + 1][j] + max_val[i][k] * max_val[k + 1][j]);
                    max_val[i][j] = max(max_val[i][j], max(max_val[i][k], max_val[k + 1][j]));
                }
            }
        }

        return dp[0][n - 1];
    }
};
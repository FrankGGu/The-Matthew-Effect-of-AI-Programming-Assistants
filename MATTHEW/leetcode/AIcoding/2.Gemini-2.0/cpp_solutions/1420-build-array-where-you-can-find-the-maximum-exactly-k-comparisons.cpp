#include <vector>

using namespace std;

class Solution {
public:
    int numOfArrays(int n, int m, int k) {
        int mod = 1e9 + 7;
        vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(m + 1, vector<int>(k + 1, 0)));
        vector<vector<vector<int>>> prefix_sum(n + 1, vector<vector<int>>(m + 1, vector<int>(k + 1, 0)));

        for (int i = 1; i <= m; ++i) {
            dp[1][i][1] = 1;
            prefix_sum[1][i][1] = (prefix_sum[1][i - 1][1] + dp[1][i][1]) % mod;
        }

        for (int i = 2; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                for (int l = 1; l <= k; ++l) {
                    dp[i][j][l] = (1LL * dp[i][j][l] + 1LL * dp[i - 1][j][l] * j % mod) % mod;
                    dp[i][j][l] = (1LL * dp[i][j][l] + prefix_sum[i - 1][j - 1][l - 1]) % mod;
                }
                for (int l = 1; l <= k; ++l) {
                   prefix_sum[i][j][l] = (prefix_sum[i][j - 1][l] + dp[i][j][l]) % mod;
                }
            }
        }

        int result = 0;
        for (int i = 1; i <= m; ++i) {
            result = (result + dp[n][i][k]) % mod;
        }

        return result;
    }
};
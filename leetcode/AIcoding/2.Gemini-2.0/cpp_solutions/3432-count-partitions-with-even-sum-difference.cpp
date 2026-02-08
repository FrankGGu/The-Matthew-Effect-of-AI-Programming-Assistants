#include <vector>

using namespace std;

const int MOD = 1e9 + 7;

int countPartitions(int n, int k) {
    if (k == 0) {
        long long pow2 = 1;
        for (int i = 0; i < n - 1; ++i) {
            pow2 = (pow2 * 2) % MOD;
        }
        return pow2;
    }

    if (n == 0) {
        return (k == 0) ? 1 : 0;
    }

    vector<vector<int>> dp(n + 1, vector<int>(k + 1, 0));
    dp[0][0] = 1;

    for (int i = 1; i <= n; ++i) {
        for (int j = 0; j <= k; ++j) {
            dp[i][j] = dp[i - 1][j];
            if (j >= i) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j - i]) % MOD;
            }
        }
    }

    long long ans = (dp[n][k] * 2LL) % MOD;
    return ans;
}
#include <vector>

using namespace std;

class Solution {
public:
    int numberOfWays(int startPos, int endPos, int k) {
        int diff = abs(startPos - endPos);
        if (diff > k) {
            return 0;
        }
        if ((k - diff) % 2 != 0) {
            return 0;
        }

        vector<vector<long long>> dp(k + 1, vector<long long>(2 * k + 1, 0));
        dp[0][k] = 1;
        int mod = 1e9 + 7;

        for (int i = 1; i <= k; ++i) {
            for (int j = 0; j <= 2 * k; ++j) {
                if (j > 0) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % mod;
                }
                if (j < 2 * k) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j + 1]) % mod;
                }
            }
        }

        return dp[k][k + (endPos - startPos)];
    }
};
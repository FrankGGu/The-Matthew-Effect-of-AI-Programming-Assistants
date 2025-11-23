#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfWays(int pos, int k) {
        const int MOD = 1e9 + 7;
        vector<vector<int>> dp(k + 1, vector<int>(2 * k + 2, 0));
        dp[0][k] = 1;

        for (int step = 1; step <= k; ++step) {
            for (int i = 0; i <= 2 * k; ++i) {
                if (i - 1 >= 0) dp[step][i] = (dp[step][i] + dp[step - 1][i - 1]) % MOD;
                if (i + 1 <= 2 * k) dp[step][i] = (dp[step][i] + dp[step - 1][i + 1]) % MOD;
            }
        }

        return dp[k][pos + k];
    }
};
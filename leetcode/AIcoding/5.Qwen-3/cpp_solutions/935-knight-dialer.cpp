#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int knightDialer(int n) {
        const int MOD = 1000000007;
        vector<vector<int>> dp(n, vector<int>(10, 0));
        vector<int> next_pos = {4, 3, 2, 3, 4, 0, 1, 2, 1, 2};

        for (int i = 0; i < 10; ++i) {
            dp[0][i] = 1;
        }

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < 10; ++j) {
                dp[i][j] = dp[i - 1][next_pos[j]];
                if (j == 0 || j == 1 || j == 2 || j == 5 || j == 8) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][next_pos[j] + 1]) % MOD;
                } else if (j == 3 || j == 6 || j == 9) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][next_pos[j] - 1]) % MOD;
                }
            }
        }

        int result = 0;
        for (int i = 0; i < 10; ++i) {
            result = (result + dp[n - 1][i]) % MOD;
        }

        return result;
    }
};
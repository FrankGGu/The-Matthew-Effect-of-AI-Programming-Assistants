#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numOfArrays(int n, int k, int target) {
        const int MOD = 1e9 + 7;
        vector<vector<int>> dp(k + 1, vector<int>(target + 1, 0));

        for (int j = 1; j <= target; ++j) {
            dp[1][j] = 1;
        }

        for (int i = 2; i <= k; ++i) {
            for (int j = 1; j <= target; ++j) {
                for (int m = 1; m <= j; ++m) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][m]) % MOD;
                }
            }
        }

        int result = 0;
        for (int j = 1; j <= target; ++j) {
            result = (result + dp[k][j]) % MOD;
        }

        return result;
    }
};
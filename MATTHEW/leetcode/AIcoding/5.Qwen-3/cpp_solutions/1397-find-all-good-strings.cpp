#include <iostream>
#include <vector>
#include <string>

class Solution {
public:
    int numberOfGoodStrings(int n, int k) {
        std::vector<int> dp(n + 1, 0);
        dp[0] = 1;
        for (int i = 1; i <= n; ++i) {
            dp[i] = (dp[i - 1] * (k - 1)) % 1000000007;
            if (i >= 2) {
                dp[i] = (dp[i] + dp[i - 2]) % 1000000007;
            }
        }
        return dp[n];
    }
};
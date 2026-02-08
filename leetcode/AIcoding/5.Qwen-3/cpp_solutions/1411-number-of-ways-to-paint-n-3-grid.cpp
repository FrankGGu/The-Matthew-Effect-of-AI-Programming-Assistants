#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numWays(int n) {
        if (n == 0) return 0;
        if (n == 1) return 6;

        vector<int> dp(n + 1, 0);
        dp[1] = 6;
        dp[2] = 6 * 2 + 3 * 2;

        for (int i = 3; i <= n; ++i) {
            dp[i] = (dp[i - 1] * 2 + dp[i - 2] * 2) % 1000000007;
        }

        return dp[n];
    }
};
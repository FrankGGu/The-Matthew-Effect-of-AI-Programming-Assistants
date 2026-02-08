#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numWays(int n, int k) {
        if (n == 0) return 1;
        if (k == 1) return 1;

        vector<int> dp(n + 1, 0);
        dp[0] = 1;
        dp[1] = k;

        for (int i = 2; i <= n; ++i) {
            dp[i] = (dp[i - 1] + dp[i - 2]) * (k - 1);
        }

        return dp[n];
    }
};
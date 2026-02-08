#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int waysToReachKthStair(int k) {
        if (k == 0) return 1;
        vector<int> dp(k + 1, 0);
        dp[0] = 1;
        for (int i = 1; i <= k; ++i) {
            dp[i] = dp[i - 1];
            if (i >= 2) dp[i] += dp[i - 2];
        }
        return dp[k];
    }
};
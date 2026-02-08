#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int peopleAwareOfSecret(int n, int k) {
        vector<int> dp(n + 1, 0);
        dp[0] = 1;
        for (int i = 1; i <= n; ++i) {
            if (i - k >= 0) {
                dp[i] = dp[i - k];
            }
            if (i - 1 >= 0 && i - 1 < n) {
                dp[i] += dp[i - 1];
            }
        }
        return dp[n];
    }
};
#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int valueAfterKSeconds(int k, int n) {
        vector<int> dp(n, 0);
        dp[0] = 1;
        for (int i = 0; i < k; ++i) {
            vector<int> newDp(n, 0);
            newDp[0] = 1;
            for (int j = 1; j < n; ++j) {
                newDp[j] = dp[j] + newDp[j - 1];
            }
            dp = newDp;
        }
        return dp[n - 1];
    }
};
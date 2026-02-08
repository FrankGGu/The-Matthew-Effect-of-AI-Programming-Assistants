#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int minimumOperations(string s) {
        int n = s.length();
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1] + 1;
            if (i >= 2) {
                dp[i] = min(dp[i], dp[i - 2] + 1);
            }
            if (i >= 4) {
                dp[i] = min(dp[i], dp[i - 4] + 1);
            }
        }
        return dp[n];
    }
};
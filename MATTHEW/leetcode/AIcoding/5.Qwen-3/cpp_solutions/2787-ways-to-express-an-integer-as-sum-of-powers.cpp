#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countIntegers(int n, int k) {
        vector<int> dp(n + 1, 0);
        dp[0] = 1;
        for (int i = 1; i <= k; ++i) {
            for (int j = i; j <= n; ++j) {
                dp[j] += dp[j - i];
            }
        }
        return dp[n];
    }
};
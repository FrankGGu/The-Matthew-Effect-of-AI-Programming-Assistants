#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int numSquares(int n) {
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            int min_val = INT_MAX;
            int j = 1;
            while (j * j <= i) {
                min_val = min(min_val, dp[i - j * j] + 1);
                ++j;
            }
            dp[i] = min_val;
        }
        return dp[n];
    }
};
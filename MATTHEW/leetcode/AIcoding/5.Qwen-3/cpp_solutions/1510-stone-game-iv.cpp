#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    bool winner(int n) {
        vector<bool> dp(n + 1, false);
        for (int i = 1; i <= n; ++i) {
            int j = 1;
            while (j * j <= i) {
                if (!dp[i - j * j]) {
                    dp[i] = true;
                    break;
                }
                ++j;
            }
        }
        return dp[n];
    }
};
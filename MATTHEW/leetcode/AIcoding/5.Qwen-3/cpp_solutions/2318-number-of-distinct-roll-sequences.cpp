#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int distinctSequences(int n) {
        if (n == 1) return 6;

        vector<int> dp(6, 1);
        for (int i = 2; i <= n; ++i) {
            vector<int> new_dp(6, 0);
            for (int j = 0; j < 6; ++j) {
                for (int k = 0; k < 6; ++k) {
                    if (j != k && abs(j - k) > 1) {
                        new_dp[j] += dp[k];
                    }
                }
            }
            dp = new_dp;
        }

        return accumulate(dp.begin(), dp.end(), 0);
    }
};
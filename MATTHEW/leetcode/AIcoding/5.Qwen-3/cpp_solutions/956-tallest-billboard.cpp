#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int tallestBillboard(const vector<int>& rods) {
        unordered_map<int, int> dp;
        dp[0] = 0;
        for (int rod : rods) {
            unordered_map<int, int> new_dp(dp);
            for (const auto& [diff, max_len] : dp) {
                int new_diff = diff + rod;
                int new_max_len = max(max_len, dp[diff] + rod);
                if (new_dp.find(new_diff) == new_dp.end() || new_dp[new_diff] < new_max_len) {
                    new_dp[new_diff] = new_max_len;
                }
                new_diff = abs(diff - rod);
                new_max_len = max(max_len, dp[diff]);
                if (new_dp.find(new_diff) == new_dp.end() || new_dp[new_diff] < new_max_len) {
                    new_dp[new_diff] = new_max_len;
                }
            }
            dp = new_dp;
        }
        return dp[0];
    }
};
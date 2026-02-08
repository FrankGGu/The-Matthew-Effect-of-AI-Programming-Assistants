#include <vector>
#include <numeric>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int tallestBillboard(vector<int>& rods) {
        int sum = accumulate(rods.begin(), rods.end(), 0);
        unordered_map<int, int> dp;
        dp[0] = 0;

        for (int rod : rods) {
            unordered_map<int, int> new_dp = dp;
            for (auto const& [diff, height] : dp) {
                int new_diff1 = diff + rod;
                new_dp[new_diff1] = max(new_dp[new_diff1], height + rod);

                int new_diff2 = abs(diff - rod);
                new_dp[new_diff2] = max(new_dp[new_diff2], height + min(diff, rod));
            }
            dp = new_dp;
        }

        return dp[0];
    }
};
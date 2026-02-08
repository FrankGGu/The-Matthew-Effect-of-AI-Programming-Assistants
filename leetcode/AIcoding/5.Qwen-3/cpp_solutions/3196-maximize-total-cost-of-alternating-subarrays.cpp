#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxTotalCost(vector<int>& nums) {
        int n = nums.size();
        vector<long long> dp(n, 0);
        dp[0] = nums[0];

        for (int i = 1; i < n; ++i) {
            if (nums[i] > nums[i - 1]) {
                dp[i] = dp[i - 1] + nums[i];
            } else {
                dp[i] = dp[i - 1] - nums[i];
            }
        }

        return *max_element(dp.begin(), dp.end());
    }
};
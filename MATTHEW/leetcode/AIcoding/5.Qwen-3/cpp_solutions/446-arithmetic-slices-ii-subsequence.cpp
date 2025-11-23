#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfArithmeticSlices(vector<int>& nums) {
        int n = nums.size();
        vector<unordered_map<long, int>> dp(n);
        int result = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                long diff = static_cast<long>(nums[i]) - nums[j];
                dp[i][diff] += dp[j][diff] + 1;
                result += dp[j][diff];
            }
        }

        return result;
    }
};
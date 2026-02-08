#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findTargetSumWays(vector<int>& nums, int target) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (abs(target) > sum || (sum + target) % 2 != 0) {
            return 0;
        }
        int s = (sum + target) / 2;
        vector<int> dp(s + 1, 0);
        dp[0] = 1;
        for (int num : nums) {
            for (int i = s; i >= num; i--) {
                dp[i] += dp[i - num];
            }
        }
        return dp[s];
    }
};
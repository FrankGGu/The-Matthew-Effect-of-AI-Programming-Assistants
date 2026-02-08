#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findTargetSumWays(vector<int>& nums, int target) {
        unordered_map<int, int> dp;
        dp[0] = 1;
        for (int num : nums) {
            unordered_map<int, int> next_dp;
            for (auto& [sum, count] : dp) {
                next_dp[sum + num] += count;
                next_dp[sum - num] += count;
            }
            dp = next_dp;
        }
        return dp[target];
    }
};
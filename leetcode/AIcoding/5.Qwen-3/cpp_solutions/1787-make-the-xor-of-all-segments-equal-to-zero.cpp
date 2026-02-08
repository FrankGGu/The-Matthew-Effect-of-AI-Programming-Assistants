#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(1 << 8, 0);
        for (int i = 0; i < n; ++i) {
            vector<int> new_dp(1 << 8, 1e9);
            for (int mask = 0; mask < (1 << 8); ++mask) {
                if (dp[mask] != 1e9) {
                    new_dp[mask ^ nums[i]] = min(new_dp[mask ^ nums[i]], dp[mask] + 1);
                    new_dp[mask] = min(new_dp[mask], dp[mask]);
                }
            }
            dp = new_dp;
        }
        return dp[0];
    }
};
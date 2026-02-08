#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int lengthOfLongestSubsequence(vector<int>& nums, int target) {
        unordered_map<int, int> dp;
        dp[0] = 0;
        for (int num : nums) {
            for (int t = target; t >= num; --t) {
                if (dp.find(t - num) != dp.end()) {
                    dp[t] = max(dp[t], dp[t - num] + 1);
                }
            }
        }
        return dp[target];
    }
};
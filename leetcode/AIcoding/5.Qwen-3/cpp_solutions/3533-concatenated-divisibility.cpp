#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findTheInteger(vector<int>& nums, int k) {
        vector<int> dp;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] % k == 0) {
                dp.push_back(nums[i]);
            }
        }
        return dp.empty() ? -1 : dp[0];
    }
};
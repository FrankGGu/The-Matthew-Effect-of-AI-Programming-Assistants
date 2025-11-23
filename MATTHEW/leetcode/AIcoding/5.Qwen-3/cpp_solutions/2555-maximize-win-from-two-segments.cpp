#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeWin(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> dp(n + 1, 0);
        int res = 0;
        for (int i = 0; i < n; ++i) {
            int j = upper_bound(nums.begin(), nums.end(), nums[i] - k) - nums.begin();
            dp[i + 1] = dp[j] + i - j + 1;
            res = max(res, dp[i + 1]);
        }
        return res;
    }
};
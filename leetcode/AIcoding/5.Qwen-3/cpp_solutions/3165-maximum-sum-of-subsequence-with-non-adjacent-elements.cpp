#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int maximumSumSubsequence(vector<int>& nums, int k) {
        int n = nums.size();
        if (n == 0) return 0;
        if (k == 1) return *max_element(nums.begin(), nums.end());

        vector<int> dp(n, 0);
        dp[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            dp[i] = max(dp[i - 1], nums[i]);
            for (int j = i - 2; j >= max(0, i - k); --j) {
                dp[i] = max(dp[i], nums[i] + dp[j]);
            }
        }
        return dp[n - 1];
    }
};
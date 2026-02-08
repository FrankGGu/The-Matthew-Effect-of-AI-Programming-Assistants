#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minMoves(vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) return 0;

        vector<int> dp(n, 0);
        for (int i = 1; i < n; ++i) {
            if (nums[i] > nums[i - 1]) {
                dp[i] = dp[i - 1];
            } else {
                dp[i] = dp[i - 1] + (nums[i - 1] - nums[i] + 1);
                nums[i] += (nums[i - 1] - nums[i] + 1);
            }
        }
        return dp[n - 1];
    }
};
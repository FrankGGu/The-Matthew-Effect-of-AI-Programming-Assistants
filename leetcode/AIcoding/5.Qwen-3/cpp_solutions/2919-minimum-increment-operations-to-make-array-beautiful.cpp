#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minIncrementOperationsToMakeArrayBeautiful(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n, 0);

        for (int i = 2; i < n; ++i) {
            dp[i] = nums[i] + min(dp[i - 1], dp[i - 2]);
        }

        return min(dp[n - 1], dp[n - 2]);
    }
};
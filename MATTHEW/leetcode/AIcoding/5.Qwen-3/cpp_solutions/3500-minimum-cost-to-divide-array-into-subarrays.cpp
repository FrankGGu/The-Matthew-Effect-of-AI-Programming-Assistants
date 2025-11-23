#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minCostToDivideArray(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            int maxVal = nums[i - 1];
            int minCost = INT_MAX;
            for (int j = i - 1; j >= max(0, i - k); --j) {
                maxVal = max(maxVal, nums[j]);
                if (dp[j] != INT_MAX) {
                    minCost = min(minCost, dp[j] + maxVal);
                }
            }
            dp[i] = minCost;
        }

        return dp[n];
    }
};
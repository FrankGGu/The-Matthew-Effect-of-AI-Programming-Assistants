#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minCostToSplit(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 0; i < n; ++i) {
            int maxVal = nums[i];
            int cost = 0;
            for (int j = i; j >= 0 && j >= i - k + 1; --j) {
                maxVal = max(maxVal, nums[j]);
                if (dp[j] != INT_MAX) {
                    dp[i + 1] = min(dp[i + 1], dp[j] + cost);
                }
                cost += maxVal;
            }
        }

        return dp[n];
    }
};
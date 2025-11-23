#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minCostToSplitArray(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 0; i < n; ++i) {
            int currentLength = 0;
            int currentCost = 0;
            for (int j = i; j < n; ++j) {
                currentLength++;
                if (currentLength > k) break;
                currentCost += nums[j];
                dp[j + 1] = min(dp[j + 1], dp[i] + currentCost);
            }
        }

        return dp[n];
    }
};
#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int totalSteps(int n, vector<int>& nums) {
        vector<int> dp(n, 0);
        int maxSteps = 0;
        for (int i = 1; i < n; ++i) {
            for (int j = i - 1; j >= 0 && nums[j] > nums[i]; --j) {
                dp[i] = max(dp[i], dp[j] + 1);
            }
            maxSteps = max(maxSteps, dp[i]);
        }
        return maxSteps;
    }
};
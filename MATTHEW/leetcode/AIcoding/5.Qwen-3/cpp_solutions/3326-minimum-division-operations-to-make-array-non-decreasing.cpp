#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n, 1);
        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] >= nums[j]) {
                    dp[i] = max(dp[i], dp[j] + 1);
                }
            }
        }
        int maxLen = *max_element(dp.begin(), dp.end());
        return n - maxLen;
    }
};
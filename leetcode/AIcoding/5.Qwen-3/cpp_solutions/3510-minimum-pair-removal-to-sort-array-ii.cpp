#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumPairRemovalToSortArrayII(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n, 1);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[j] <= nums[i]) {
                    dp[i] = max(dp[i], dp[j] + 1);
                }
            }
        }

        int maxLength = *max_element(dp.begin(), dp.end());
        return n - maxLength;
    }
};
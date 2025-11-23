#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int maximumSum(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp0(n, 0);         vector<int> dp1(n, 0); 
        dp0[0] = nums[0];
        dp1[0] = -INT_MAX;

        for (int i = 1; i < n; ++i) {
            dp0[i] = max(nums[i], dp0[i - 1] + nums[i]);
            dp1[i] = max(dp1[i - 1] + nums[i], dp0[i - 1]);
        }

        int maxSum = *max_element(dp0.begin(), dp0.end());
        return max(maxSum, *max_element(dp1.begin(), dp1.end()));
    }
};
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxAdjacentDifference(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return 0;

        int minVal = nums[0], maxVal = nums[0];
        for (int i = 1; i < n; ++i) {
            minVal = min(minVal, nums[i]);
            maxVal = max(maxVal, nums[i]);
        }

        int result = 0;
        for (int i = 1; i < n; ++i) {
            result = max(result, abs(nums[i] - nums[i - 1]));
        }
        result = max(result, abs(nums[0] - nums[n - 1]));

        return result;
    }
};
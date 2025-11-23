#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int smallestRangeII(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int minRange = nums[n - 1] - nums[0];

        for (int i = 0; i < n - 1; ++i) {
            int a = nums[i] + k;
            int b = nums[i + 1] - k;
            int currMin = min(a, b);
            int currMax = max(nums[n - 1] - k, nums[0] + k);
            minRange = min(minRange, currMax - currMin);
        }

        return minRange;
    }
};
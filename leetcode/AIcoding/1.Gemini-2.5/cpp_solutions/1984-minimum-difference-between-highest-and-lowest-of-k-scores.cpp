#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumDifference(vector<int>& nums, int k) {
        if (k <= 1) return 0;
        sort(nums.begin(), nums.end());
        int min_diff = nums[k - 1] - nums[0];
        for (int i = 1; i <= nums.size() - k; ++i) {
            min_diff = min(min_diff, nums[i + k - 1] - nums[i]);
        }
        return min_diff;
    }
};
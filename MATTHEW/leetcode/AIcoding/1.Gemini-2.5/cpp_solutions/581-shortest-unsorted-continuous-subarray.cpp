#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int findUnsortedSubarray(std::vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) {
            return 0;
        }

        int max_val = INT_MIN;
        int end = -1;
        for (int i = 0; i < n; ++i) {
            max_val = std::max(max_val, nums[i]);
            if (nums[i] < max_val) {
                end = i;
            }
        }

        if (end == -1) {
            return 0;
        }

        int min_val = INT_MAX;
        int start = -1;
        for (int i = n - 1; i >= 0; --i) {
            min_val = std::min(min_val, nums[i]);
            if (nums[i] > min_val) {
                start = i;
            }
        }

        return end - start + 1;
    }
};
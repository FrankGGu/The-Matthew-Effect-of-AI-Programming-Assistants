#include <vector>
#include <algorithm>

class Solution {
public:
    int dominantIndex(std::vector<int>& nums) {
        if (nums.empty()) {
            return -1;
        }

        int max1 = -1; // Largest element
        int max2 = -1; // Second largest element
        int max1_idx = -1; // Index of the largest element

        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] > max1) {
                max2 = max1; // Old max1 becomes new max2
                max1 = nums[i];
                max1_idx = i;
            } else if (nums[i] > max2) {
                max2 = nums[i];
            }
        }

        if (max1 >= 2 * max2) {
            return max1_idx;
        } else {
            return -1;
        }
    }
};
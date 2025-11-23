#include <vector>
#include <algorithm> // For std::max and std::min

class Solution {
public:
    int maximumDifference(std::vector<int>& nums) {
        int max_diff = -1;
        int min_so_far = nums[0]; 

        for (int j = 1; j < nums.size(); ++j) {
            if (nums[j] > min_so_far) {
                max_diff = std::max(max_diff, nums[j] - min_so_far);
            }
            min_so_far = std::min(min_so_far, nums[j]);
        }

        return max_diff;
    }
};
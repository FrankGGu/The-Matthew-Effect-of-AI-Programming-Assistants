#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> searchRange(std::vector<int>& nums, int target) {
        auto lower = std::lower_bound(nums.begin(), nums.end(), target);

        if (lower == nums.end() || *lower != target) {
            return {-1, -1};
        }

        auto upper = std::upper_bound(nums.begin(), nums.end(), target);

        int first_pos = std::distance(nums.begin(), lower);
        int last_pos = std::distance(nums.begin(), upper) - 1;

        return {first_pos, last_pos};
    }
};
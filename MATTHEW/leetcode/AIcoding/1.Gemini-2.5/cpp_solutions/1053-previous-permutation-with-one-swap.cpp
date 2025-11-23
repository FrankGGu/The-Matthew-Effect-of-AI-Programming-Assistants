#include <vector>
#include <algorithm> // For std::swap, std::lower_bound

class Solution {
public:
    std::vector<int> prevPermutationWithOneSwap(std::vector<int>& nums) {
        int n = nums.size();

        int i = n - 2;
        while (i >= 0 && nums[i] <= nums[i+1]) {
            i--;
        }

        if (i == -1) {
            return nums;
        }

        auto it = std::lower_bound(nums.begin() + i + 1, nums.end(), nums[i]);

        it--; 

        int j = std::distance(nums.begin(), it);

        std::swap(nums[i], nums[j]);

        return nums;
    }
};
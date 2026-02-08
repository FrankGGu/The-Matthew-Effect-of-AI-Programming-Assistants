#include <vector>
#include <utility>

class Solution {
public:
    std::vector<int> applyOperations(std::vector<int>& nums) {
        int n = nums.size();
        for (int i = 0; i < n - 1; ++i) {
            if (nums[i] == nums[i + 1]) {
                nums[i] *= 2;
                nums[i + 1] = 0;
            }
        }

        int insertPos = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] != 0) {
                std::swap(nums[insertPos++], nums[i]);
            }
        }

        return nums;
    }
};
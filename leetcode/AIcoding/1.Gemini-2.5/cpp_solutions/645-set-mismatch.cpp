#include <vector>
#include <cmath> // For std::abs

class Solution {
public:
    std::vector<int> findErrorNums(std::vector<int>& nums) {
        int duplicate = -1;
        int missing = -1;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            int val = std::abs(nums[i]);
            if (nums[val - 1] < 0) {
                duplicate = val;
            } else {
                nums[val - 1] *= -1;
            }
        }

        for (int i = 0; i < n; ++i) {
            if (nums[i] > 0) {
                missing = i + 1;
                break;
            }
        }

        return {duplicate, missing};
    }
};
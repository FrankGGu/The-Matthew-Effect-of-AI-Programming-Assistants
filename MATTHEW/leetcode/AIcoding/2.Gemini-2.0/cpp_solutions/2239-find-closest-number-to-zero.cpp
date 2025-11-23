#include <vector>
#include <algorithm>
#include <cmath>

class Solution {
public:
    int findClosestNumber(std::vector<int>& nums) {
        int closest = nums[0];
        for (int num : nums) {
            if (std::abs(num) < std::abs(closest)) {
                closest = num;
            } else if (std::abs(num) == std::abs(closest)) {
                closest = std::max(closest, num);
            }
        }
        return closest;
    }
};
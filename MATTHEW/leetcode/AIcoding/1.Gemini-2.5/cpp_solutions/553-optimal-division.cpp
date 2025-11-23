#include <vector>
#include <string>

class Solution {
public:
    std::string optimalDivision(std::vector<int>& nums) {
        int n = nums.size();

        if (n == 1) {
            return std::to_string(nums[0]);
        }
        if (n == 2) {
            return std::to_string(nums[0]) + "/" + std::to_string(nums[1]);
        }

        std::string result = std::to_string(nums[0]) + "/(";
        for (int i = 1; i < n; ++i) {
            result += std::to_string(nums[i]);
            if (i < n - 1) {
                result += "/";
            }
        }
        result += ")";
        return result;
    }
};
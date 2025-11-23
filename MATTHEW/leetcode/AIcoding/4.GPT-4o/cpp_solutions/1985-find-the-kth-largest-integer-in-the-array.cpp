#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::string kthLargestNumber(std::vector<std::string>& nums, int k) {
        std::sort(nums.begin(), nums.end(), [](const std::string &a, const std::string &b) {
            if (a.size() != b.size()) return a.size() > b.size();
            return a > b;
        });
        return nums[k - 1];
    }
};
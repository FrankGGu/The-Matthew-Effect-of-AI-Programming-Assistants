#include <numeric>
#include <vector>

class Solution {
public:
    int findGCD(std::vector<int>& nums) {
        int min_num = nums[0];
        int max_num = nums[0];
        for (int num : nums) {
            min_num = std::min(min_num, num);
            max_num = std::max(max_num, num);
        }
        return std::gcd(min_num, max_num);
    }
};
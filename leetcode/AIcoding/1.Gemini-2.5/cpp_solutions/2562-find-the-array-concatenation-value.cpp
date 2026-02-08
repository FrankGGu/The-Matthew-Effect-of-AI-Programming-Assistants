#include <vector>
#include <string>

class Solution {
public:
    long long findTheArrayConcatenationValue(std::vector<int>& nums) {
        long long ans = 0;
        int left = 0;
        int right = nums.size() - 1;

        while (left <= right) {
            if (left < right) {
                std::string s = std::to_string(nums[left]) + std::to_string(nums[right]);
                ans += std::stoll(s);
            } else {
                ans += nums[left];
            }
            left++;
            right--;
        }

        return ans;
    }
};
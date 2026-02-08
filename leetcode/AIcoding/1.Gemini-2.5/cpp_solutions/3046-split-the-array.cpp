#include <vector>
#include <algorithm>

class Solution {
public:
    bool splitArray(std::vector<int>& nums) {
        int n = nums.size();
        int half_n = n / 2;

        int max_nums1 = *std::max_element(nums.begin(), nums.begin() + half_n);
        int min_nums2 = *std::min_element(nums.begin() + half_n, nums.end());

        return max_nums1 < min_nums2;
    }
};
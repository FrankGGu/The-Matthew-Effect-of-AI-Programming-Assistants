#include <vector>
#include <algorithm>

class Solution {
public:
    int findTheInteger(std::vector<int>& nums1, std::vector<int>& nums2) {
        return nums2[0] - nums1[0];
    }
};
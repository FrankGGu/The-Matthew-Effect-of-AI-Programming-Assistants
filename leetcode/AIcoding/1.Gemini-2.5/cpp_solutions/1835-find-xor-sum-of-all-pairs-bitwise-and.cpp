#include <vector>
#include <numeric>

class Solution {
public:
    int getXORSum(std::vector<int>& nums1, std::vector<int>& nums2) {
        int xorSum1 = 0;
        for (int num : nums1) {
            xorSum1 ^= num;
        }

        int xorSum2 = 0;
        for (int num : nums2) {
            xorSum2 ^= num;
        }

        return xorSum1 & xorSum2;
    }
};
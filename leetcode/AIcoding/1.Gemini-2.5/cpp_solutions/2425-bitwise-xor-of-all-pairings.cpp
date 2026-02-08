#include <vector>
#include <numeric>
#include <functional>

class Solution {
public:
    int xorAllNums(std::vector<int>& nums1, std::vector<int>& nums2) {
        int n = nums1.size();
        int m = nums2.size();

        int xor_sum1 = 0;
        if (m % 2 != 0) {
            xor_sum1 = std::accumulate(nums1.begin(), nums1.end(), 0, std::bit_xor<int>());
        }

        int xor_sum2 = 0;
        if (n % 2 != 0) {
            xor_sum2 = std::accumulate(nums2.begin(), nums2.end(), 0, std::bit_xor<int>());
        }

        return xor_sum1 ^ xor_sum2;
    }
};
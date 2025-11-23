#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long minSum(std::vector<int>& nums1, std::vector<int>& nums2) {
        long long sum1 = 0;
        long long zeros1 = 0;
        for (int x : nums1) {
            if (x == 0) {
                zeros1++;
            }
            sum1 += x;
        }

        long long sum2 = 0;
        long long zeros2 = 0;
        for (int x : nums2) {
            if (x == 0) {
                zeros2++;
            }
            sum2 += x;
        }

        long long min_sum1 = sum1 + zeros1;
        long long min_sum2 = sum2 + zeros2;

        if (zeros1 == 0 && min_sum1 < min_sum2) {
            return -1;
        }

        if (zeros2 == 0 && min_sum2 < min_sum1) {
            return -1;
        }

        return std::max(min_sum1, min_sum2);
    }
};
#include <iostream>
#include <vector>
#include <cmath>

class Solution {
public:
    int minCost(std::vector<int>& nums1, std::vector<int>& nums2, int x) {
        int n = nums1.size();
        std::vector<int> diff(n);
        for (int i = 0; i < n; ++i) {
            diff[i] = std::abs(nums1[i] - nums2[i]);
        }
        std::sort(diff.begin(), diff.end());
        int res = 0;
        for (int i = 0; i < n; ++i) {
            res += diff[i] * i;
        }
        return res;
    }
};
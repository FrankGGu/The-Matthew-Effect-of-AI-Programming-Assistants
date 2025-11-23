#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int numberofPairs(std::vector<int>& nums1, std::vector<int>& nums2) {
        int n = nums1.size();
        std::vector<int> diff(n);
        for (int i = 0; i < n; ++i) {
            diff[i] = nums1[i] - nums2[i];
        }
        std::sort(diff.begin(), diff.end());
        int count = 0;
        for (int i = 0; i < n; ++i) {
            int target = -diff[i];
            auto it = std::upper_bound(diff.begin() + i + 1, diff.end(), target);
            count += (it - diff.begin() - i - 1);
        }
        return count;
    }
};
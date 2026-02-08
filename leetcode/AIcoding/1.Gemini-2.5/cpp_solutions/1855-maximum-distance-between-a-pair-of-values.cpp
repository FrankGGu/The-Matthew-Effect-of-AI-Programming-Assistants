#include <vector>
#include <algorithm>

class Solution {
public:
    int maxDistance(std::vector<int>& nums1, std::vector<int>& nums2) {
        int i = 0;
        int j = 0;
        int max_dist = 0;

        while (i < nums1.size() && j < nums2.size()) {
            if (nums1[i] > nums2[j]) {
                i++;
            } else {
                max_dist = std::max(max_dist, j - i);
                j++;
            }
        }

        return max_dist;
    }
};
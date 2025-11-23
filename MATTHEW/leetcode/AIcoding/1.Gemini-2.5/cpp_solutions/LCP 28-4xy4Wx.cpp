#include <vector>
#include <algorithm>

class Solution {
public:
    long long procurementPlan(std::vector<int>& nums1, std::vector<int>& nums2, int k) {
        std::sort(nums1.begin(), nums1.end());
        std::sort(nums2.begin(), nums2.end());

        long long count = 0;
        int n1 = nums1.size();
        int n2 = nums2.size();

        int left = 0;
        int right = n2 - 1;

        while (left < n1 && right >= 0) {
            long long current_sum = (long long)nums1[left] + nums2[right];

            if (current_sum <= k) {
                count += (right + 1);
                left++;
            } else {
                right--;
            }
        }

        return count;
    }
};
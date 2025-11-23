#include <vector>
#include <algorithm>
#include <cmath>

class Solution {
public:
    long long count_le(long long val, const std::vector<int>& nums1, const std::vector<int>& nums2) {
        long long count = 0;
        int n2 = nums2.size();

        for (int x : nums1) {
            if (x == 0) {
                if (val >= 0) {
                    count += n2;
                }
            } else if (x > 0) {
                // We need x * y <= val  =>  y <= val / x
                // Integer division `val / x` truncates towards zero.
                // For x > 0, this correctly gives floor(val / x) for positive val,
                // and effectively ceil(val / x) for negative val (e.g., -7/2 = -3, we want y <= -3).
                long long target_y = val / x;
                auto it = std::upper_bound(nums2.begin(), nums2.end(), target_y);
                count += (it - nums2.begin());
            } else { // x < 0
                // We need x * y <= val  =>  y >= val / x (inequality reverses)
                // We need to find count of elements >= ceil(val / x).
                long long target_y_lower_bound = (long long)std::ceil((double)val / x);
                auto it = std::lower_bound(nums2.begin(), nums2.end(), target_y_lower_bound);
                count += (n2 - (it - nums2.begin()));
            }
        }
        return count;
    }

    long long kthSmallestProduct(std::vector<int>& nums1, std::vector<int>& nums2, long long k) {
        long long low = -100000000001LL; // Minimum possible product is -10^5 * 10^5 = -10^10
        long long high = 100000000001LL; // Maximum possible product is 10^5 * 10^5 = 10^10
        long long ans = high;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (count_le(mid, nums1, nums2) >= k) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }
};
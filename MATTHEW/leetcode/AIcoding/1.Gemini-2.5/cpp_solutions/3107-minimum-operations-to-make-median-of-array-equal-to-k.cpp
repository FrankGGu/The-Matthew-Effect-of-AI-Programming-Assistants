#include <vector>
#include <algorithm>
#include <cmath> // For std::abs

class Solution {
public:
    long long minOperationsToMakeMedianK(std::vector<int>& nums, int k) {
        std::sort(nums.begin(), nums.end());

        int n = nums.size();
        // The median is the element at index (n-1)/2 according to the problem description
        // (left of the two middle elements for even n, middle for odd n).
        int median_idx = (n - 1) / 2; 

        long long operations = 0;

        // Step 1: Make the median element equal to k.
        // This is the base cost.
        operations += std::abs(static_cast<long long>(nums[median_idx]) - k);

        // Step 2: Adjust elements to the left of the median.
        // If the original nums[median_idx] was greater than k, we effectively decreased it to k.
        // To maintain the sorted property (all elements to the left of the median must be <= k),
        // any elements nums[i] (for i < median_idx) that are currently > k must also be decreased to k.
        if (nums[median_idx] > k) {
            for (int i = median_idx - 1; i >= 0; --i) {
                if (nums[i] > k) {
                    operations += (static_cast<long long>(nums[i]) - k);
                } else {
                    // Since the array is sorted, if nums[i] <= k, all elements further to the left
                    // will also be <= k and thus do not require operations.
                    break; 
                }
            }
        }

        // Step 3: Adjust elements to the right of the median.
        // If the original nums[median_idx] was less than k, we effectively increased it to k.
        // To maintain the sorted property (all elements to the right of the median must be >= k),
        // any elements nums[i] (for i > median_idx) that are currently < k must also be increased to k.
        if (nums[median_idx] < k) {
            for (int i = median_idx + 1; i < n; ++i) {
                if (nums[i] < k) {
                    operations += (static_cast<long long>(k) - nums[i]);
                } else {
                    // Since the array is sorted, if nums[i] >= k, all elements further to the right
                    // will also be >= k and thus do not require operations.
                    break;
                }
            }
        }

        return operations;
    }
};
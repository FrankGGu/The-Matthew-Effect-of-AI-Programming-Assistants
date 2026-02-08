#include <vector>
#include <algorithm> // For std::sort and std::unique

class Solution {
public:
    int minOperations(std::vector<int>& nums) {
        int n = nums.size();

        // 1. Sort the array
        std::sort(nums.begin(), nums.end());

        // 2. Remove duplicates
        // std::unique moves duplicates to the end and returns an iterator to the new end.
        // std::vector::erase removes the elements from that iterator to the actual end.
        nums.erase(std::unique(nums.begin(), nums.end()), nums.end());

        // Now nums contains only unique sorted elements
        // Let m be the number of unique elements
        int m = nums.size();

        // Initialize min_ops with the maximum possible operations (change all elements)
        int min_ops = n; 

        // Two-pointer approach to find the maximum number of elements already in a valid range
        int j = 0; // Right pointer for the sliding window
        for (int i = 0; i < m; ++i) { // Left pointer for the sliding window
            // The target continuous range for an array of length 'n' starting with nums[i]
            // would be [nums[i], nums[i] + n - 1]
            // Use long long for target_end to prevent potential overflow, though for current constraints int is fine.
            long long target_end = (long long)nums[i] + n - 1;

            // Move j to find the first element in 'nums' that is greater than 'target_end'
            while (j < m && nums[j] <= target_end) {
                j++;
            }

            // 'j - i' gives the count of unique elements from the current 'nums' array
            // that fall within the target range [nums[i], nums[i] + n - 1].
            int elements_in_range = j - i;

            // The number of operations needed for this specific window is 'n' (total needed) 
            // minus 'elements_in_range' (elements already present).
            min_ops = std::min(min_ops, n - elements_in_range);
        }

        return min_ops;
    }
};
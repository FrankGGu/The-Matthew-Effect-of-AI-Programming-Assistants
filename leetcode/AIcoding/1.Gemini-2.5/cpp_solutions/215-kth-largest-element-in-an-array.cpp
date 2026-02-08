#include <vector>
#include <algorithm> // Required for std::swap

class Solution {
public:
    int findKthLargest(std::vector<int>& nums, int k) {
        int n = nums.size();
        // The Kth largest element is equivalent to the (n - k)th smallest element
        // (0-indexed) if the array were sorted in ascending order.
        int target_idx = n - k;

        int left = 0;
        int right = n - 1;

        while (true) {
            int pivot_final_idx = partition(nums, left, right);

            if (pivot_final_idx == target_idx) {
                return nums[pivot_final_idx];
            } else if (pivot_final_idx < target_idx) {
                // The Kth largest element is in the right sub-array
                left = pivot_final_idx + 1;
            } else { // pivot_final_idx > target_idx
                // The Kth largest element is in the left sub-array
                right = pivot_final_idx - 1;
            }
        }
    }

private:
    // Standard Lomuto partition scheme, choosing the rightmost element as pivot
    int partition(std::vector<int>& nums, int left, int right) {
        int pivot_value = nums[right];
        int i = left; // 'i' is the boundary for elements less than or equal to the pivot

        for (int j = left; j < right; ++j) {
            if (nums[j] <= pivot_value) {
                std::swap(nums[i], nums[j]);
                i++;
            }
        }
        // Place the pivot element at its correct sorted position
        std::swap(nums[i], nums[right]);
        return i;
    }
};
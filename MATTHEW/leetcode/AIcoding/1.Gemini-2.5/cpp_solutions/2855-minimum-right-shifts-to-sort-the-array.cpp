#include <vector>
#include <numeric>

class Solution {
public:
    int minimumRightShifts(std::vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) {
            return 0;
        }

        int pivot_idx = -1; // Index of the element before the descent (nums[i] > nums[i+1])

        // Find the descent point
        for (int i = 0; i < n - 1; ++i) {
            if (nums[i] > nums[i+1]) {
                if (pivot_idx != -1) {
                    // More than one descent point, not a single rotation of a sorted array
                    return -1;
                }
                pivot_idx = i;
            }
        }

        if (pivot_idx == -1) {
            // Array is already sorted
            return 0;
        }

        // Check the wrap-around condition for a valid rotated sorted array:
        // The last element must be less than the first element.
        // If nums[n-1] > nums[0], it means the "tail" of the rotated array is greater than its "head",
        // which implies it's not a valid rotation of a sorted array.
        // Example: [1, 3, 2]. Here nums[2]=2, nums[0]=1. 2 > 1. Invalid.
        // Example: [3, 1, 2]. Here nums[2]=2, nums[0]=3. 2 < 3. Valid.
        if (nums[n-1] > nums[0]) {
            return -1;
        }

        // If we reach here, there's exactly one descent point, and the wrap-around condition is met.
        // The array can be sorted by right shifts.
        // The number of shifts is the count of elements from (pivot_idx + 1) to (n - 1).
        // These are the elements that were originally at the beginning of the sorted array
        // and have been shifted to the end.
        return n - (pivot_idx + 1);
    }
};
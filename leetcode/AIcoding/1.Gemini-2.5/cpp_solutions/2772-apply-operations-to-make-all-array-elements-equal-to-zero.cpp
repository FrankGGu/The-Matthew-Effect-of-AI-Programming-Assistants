#include <vector>

class Solution {
public:
    bool canMakeSubsequence(std::vector<int>& nums, int k) {
        int n = nums.size();
        for (int i = 0; i < n; ) {
            if (nums[i] != 0) {
                // If nums[i] is non-zero, we must apply an operation starting at index i
                // to make nums[i] zero.
                // An operation starting at i covers indices i, i+1, ..., i+k-1.
                // The last index covered, i+k-1, must be within array bounds (i.e., < n).
                if (i + k - 1 >= n) {
                    // If applying an operation of length k starting at i would go out of bounds,
                    // it's impossible to make nums[i] zero.
                    return false;
                }
                // Apply the operation: conceptually set nums[i] through nums[i+k-1] to 0.
                // Since these elements are now considered zero, we can skip checking them
                // and advance our pointer by k.
                i += k;
            } else {
                // If nums[i] is already zero, no operation is needed for this element.
                // Move to the next element.
                i++;
            }
        }
        // If the loop completes, it means all elements have been successfully made zero.
        return true;
    }
};
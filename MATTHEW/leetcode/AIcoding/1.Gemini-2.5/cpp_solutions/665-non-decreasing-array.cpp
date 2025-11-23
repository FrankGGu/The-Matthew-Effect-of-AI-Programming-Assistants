#include <vector>
#include <algorithm>

class Solution {
public:
    bool checkPossibility(std::vector<int>& nums) {
        int n = nums.size();
        int violations = 0;
        int violation_idx = -1;

        for (int i = 0; i < n - 1; ++i) {
            if (nums[i] > nums[i+1]) {
                violations++;
                violation_idx = i;
            }
        }

        if (violations == 0) {
            return true;
        }
        if (violations > 1) {
            return false;
        }

        // Only one violation at violation_idx
        int i = violation_idx;

        // If the violation is at the beginning (i=0) or end (i=n-2) of the array,
        // it's always possible to fix by modifying one of the two elements involved.
        // Example: [4,2,3] -> change nums[0] to 2 -> [2,2,3]
        // Example: [1,2,5,3] -> change nums[3] to 5 -> [1,2,5,5]
        if (i == 0 || i == n - 2) {
            return true;
        }

        // The violation is in the middle of the array: nums[i-1], nums[i], nums[i+1], nums[i+2]
        // We have nums[i] > nums[i+1].
        // We have two options to fix this:

        // Option A: Decrease nums[i] to nums[i+1].
        // This is valid if nums[i-1] <= nums[i+1].
        // If true, the sequence becomes nums[i-1] <= nums[i+1] (new nums[i]) <= nums[i+1].
        // The relationship between nums[i+1] (original value) and nums[i+2] remains unchanged.
        if (nums[i-1] <= nums[i+1]) {
            return true;
        }

        // Option B: Increase nums[i+1] to nums[i].
        // This option is considered if Option A is not possible (i.e., nums[i-1] > nums[i+1]).
        // We change nums[i+1] to nums[i].
        // We must check if this modification creates a new violation with nums[i+2].
        // That is, if the new nums[i+1] (which is original nums[i]) is still greater than nums[i+2].
        // If i+2 is out of bounds, there's no nums[i+2] to check against, so it's fine.
        if (i + 2 < n && nums[i] > nums[i+2]) {
            // Example: [3, 4, 2, 3]
            // i=1. nums[0]=3, nums[1]=4, nums[2]=2, nums[3]=3.
            // nums[i-1] (3) > nums[i+1] (2), so Option A fails.
            // Try Option B: change nums[i+1] (2) to nums[i] (4). Array becomes [3, 4, 4, 3].
            // Now, check nums[i+1] (4) vs nums[i+2] (3). Since 4 > 3, this creates a new violation.
            // Thus, it's impossible to make the array non-decreasing with one modification.
            return false;
        }

        // If we reach here, it means either Option A worked, or Option A failed but Option B worked
        // (i.e., changing nums[i+1] to nums[i] did not create a new violation with nums[i+2]).
        return true;
    }
};
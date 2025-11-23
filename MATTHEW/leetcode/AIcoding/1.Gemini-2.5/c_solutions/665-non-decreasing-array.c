#include <stdbool.h>

bool checkPossibility(int* nums, int numsSize) {
    int violations = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] > nums[i+1]) {
            violations++;
            if (violations > 1) {
                return false;
            }
            // Try to fix the violation
            if (i > 0 && nums[i-1] > nums[i+1]) {
                // If fixing nums[i] by setting it to nums[i+1] would create a new violation with nums[i-1],
                // then we must fix nums[i+1] by setting it to nums[i].
                nums[i+1] = nums[i];
            } else {
                // Otherwise, we can fix nums[i] by setting it to nums[i+1] (or just leave nums[i] as is and
                // set nums[i+1] to nums[i], which is effectively the same if nums[i-1] <= nums[i+1]).
                // The problem statement implies we can change at most one element.
                // If nums[i-1] <= nums[i+1], we can decrease nums[i] to nums[i+1].
                // If i == 0, we can always decrease nums[0] to nums[1].
                // So, we prioritize decreasing nums[i] if possible.
                // This line is actually not strictly necessary to modify the array,
                // as the logic for checking the next element will still work.
                // It's more about conceptually fixing it.
                // For the purpose of the algorithm, we just need to know if it's fixable.
                // The crucial part is handling the `nums[i-1] > nums[i+1]` case.
            }
        }
    }
    return true;
}
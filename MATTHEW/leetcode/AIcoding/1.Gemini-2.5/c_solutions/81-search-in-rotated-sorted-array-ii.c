#include <stdbool.h>

bool search(int* nums, int numsSize, int target) {
    if (numsSize == 0) {
        return false;
    }

    int low = 0;
    int high = numsSize - 1;

    while (low <= high) {
        int mid = low + (high - low) / 2;

        if (nums[mid] == target) {
            return true;
        }

        // Handle the case where nums[low], nums[mid], and nums[high] might be duplicates.
        // If nums[low] == nums[mid], we cannot determine which half is sorted
        // based on nums[low] and nums[mid]. Increment low to skip the duplicate.
        // The element nums[mid] has already been checked.
        if (nums[low] == nums[mid]) {
            low++;
        }
        // If the left half is sorted (nums[low] <= nums[mid])
        else if (nums[low] <= nums[mid]) {
            // Check if the target is within the sorted left half
            if (target >= nums[low] && target < nums[mid]) {
                high = mid - 1;
            } else {
                // Target is in the right (possibly rotated) half
                low = mid + 1;
            }
        }
        // If the right half is sorted (nums[low] > nums[mid])
        else { // nums[low] > nums[mid] implies the pivot is in the left half
            // Check if the target is within the sorted right half
            if (target > nums[mid] && target <= nums[high]) {
                low = mid + 1;
            } else {
                // Target is in the left (possibly rotated) half
                high = mid - 1;
            }
        }
    }

    return false;
}
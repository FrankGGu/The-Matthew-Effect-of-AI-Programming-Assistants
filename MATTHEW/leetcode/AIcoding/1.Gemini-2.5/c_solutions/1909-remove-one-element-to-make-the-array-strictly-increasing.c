#include <stdbool.h>

bool canBeIncreasing(int* nums, int numsSize) {
    int disorders = 0;
    int p = -1; // Index of the first element in the pair that causes a disorder (nums[p] >= nums[p+1])

    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] >= nums[i+1]) {
            disorders++;
            p = i; 
        }
    }

    if (disorders == 0) {
        return true; 
    }
    if (disorders > 1) {
        return false; 
    }

    // disorders == 1. We found exactly one pair (nums[p], nums[p+1]) that violates the strictly increasing condition.
    // We need to check if removing nums[p] or nums[p+1] fixes the array.

    // Option 1: Remove nums[p]
    bool remove_p_works = false;
    if (p == 0) {
        // If the first element is the problem, removing it leaves nums[1...numsSize-1] which must be sorted
        remove_p_works = true; 
    } else {
        // Check if nums[p-1] < nums[p+1]
        if (nums[p-1] < nums[p+1]) {
            remove_p_works = true;
        }
    }

    // Option 2: Remove nums[p+1]
    bool remove_p_plus_1_works = false;
    if (p + 1 == numsSize - 1) {
        // If the last element is the problem, removing it leaves nums[0...numsSize-2] which must be sorted
        remove_p_plus_1_works = true; 
    } else {
        // Check if nums[p] < nums[p+2]
        if (nums[p] < nums[p+2]) {
            remove_p_plus_1_works = true;
        }
    }

    return remove_p_works || remove_p_plus_1_works;
}
int minDeletions(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int kept_elements_count = 0;
    int last_kept_value = 0; // This value is only used when kept_elements_count is odd, after it has been set

    for (int i = 0; i < numsSize; ++i) {
        if (kept_elements_count % 2 == 0) {
            // We are looking for an element to be at an even index in the beautiful array.
            // Always keep it to maximize the number of elements.
            kept_elements_count++;
            last_kept_value = nums[i];
        } else {
            // We are looking for an element to be at an odd index.
            // It must be different from the last kept element.
            if (nums[i] != last_kept_value) {
                kept_elements_count++;
                // No need to update last_kept_value here, as the next kept element
                // will be at an even index and will set last_kept_value.
            }
            // If nums[i] == last_kept_value, we effectively "delete" nums[i] by not incrementing kept_elements_count.
            // We continue searching for a suitable element for this odd position.
        }
    }

    // After iterating through all elements, if the total count of kept elements is odd,
    // we must delete one more (the last one kept) to satisfy the even length requirement.
    if (kept_elements_count % 2 != 0) {
        kept_elements_count--;
    }

    // The minimum deletions is the original size minus the maximum number of elements we could keep.
    return numsSize - kept_elements_count;
}
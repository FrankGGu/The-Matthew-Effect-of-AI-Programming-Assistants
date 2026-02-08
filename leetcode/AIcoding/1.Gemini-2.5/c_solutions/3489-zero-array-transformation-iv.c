long long zeroArray(int* nums, int numsSize) {
    long long operations = 0;
    long long current_reduction_applied_to_elements = 0;

    for (int i = 0; i < numsSize; i++) {
        // Calculate the effective value of nums[i] after accounting for
        // reductions from operations that started at indices less than i.
        long long effective_val_at_current_index = (long long)nums[i] - current_reduction_applied_to_elements;

        if (effective_val_at_current_index > 0) {
            // If the effective value is positive, it means nums[i] still needs to be reduced.
            // We must perform 'effective_val_at_current_index' operations starting at index i.
            operations += effective_val_at_current_index;

            // These new operations contribute to the reduction of nums[i] and all subsequent elements.
            // So, we update the total reduction that will be applied to elements from i+1 onwards.
            current_reduction_applied_to_elements += effective_val_at_current_index;
        } 
        // If effective_val_at_current_index <= 0, it means nums[i] is already zero or negative
        // due to previous operations. No new operations are needed at this index.
        // The 'current_reduction_applied_to_elements' remains unchanged for the next iteration,
        // as no new operations were initiated at this index to affect subsequent elements.
    }

    return operations;
}
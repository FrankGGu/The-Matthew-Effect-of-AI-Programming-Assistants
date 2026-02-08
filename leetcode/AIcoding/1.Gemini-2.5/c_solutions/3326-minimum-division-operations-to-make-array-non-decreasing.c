int minimumDivisionOperations(int* nums, int numsSize) {
    long long operations = 0;

    // Iterate from the second to last element down to the first.
    // We want to ensure nums[i] <= nums[i+1] for all i.
    // Processing from right to left ensures that when we modify nums[i],
    // the condition nums[i] <= nums[i+1] is met, and this modification
    // only makes it easier (or keeps it the same) for nums[i-1] to satisfy
    // nums[i-1] <= nums[i].
    for (int i = numsSize - 2; i >= 0; i--) {
        // If the current element is already less than or equal to the next,
        // no operations are needed for this pair.
        if (nums[i] <= nums[i + 1]) {
            continue;
        }

        // If nums[i] > nums[i+1], we must perform divisions on nums[i].
        // The goal is to reduce nums[i] to a value 'x' such that x <= nums[i+1].
        // To minimize operations, we perform the minimum number of divisions.
        // We will divide nums[i] by 2 repeatedly until it becomes less than or equal to nums[i+1].
        int current_val = nums[i];
        int target = nums[i + 1]; // The value nums[i] must be reduced to be <= target.

        int count = 0; // Counter for operations performed on nums[i]
        while (current_val > target) {
            current_val /= 2; // Perform integer division (floor(current_val / 2))
            count++;
        }

        // Add the operations performed for this element to the total.
        operations += count;

        // Update nums[i] with its new, reduced value. This is crucial because
        // nums[i-1] will be compared against this new nums[i] in the next iteration.
        nums[i] = current_val;
    }

    // The total number of operations can fit in an int, as per constraints.
    return (int)operations;
}
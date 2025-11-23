int minOperations(int* nums, int numsSize) {
    int operations = 0;
    int flip_parity = 0; // 0 indicates an even number of prefix flips, 1 indicates an odd number.

    for (int i = 0; i < numsSize; i++) {
        // The effective value of nums[i] is its original value XORed with the current flip_parity.
        // If flip_parity is 1, it means an odd number of operations have been applied
        // to this prefix, effectively flipping nums[i] from its original state.
        int current_effective_value = nums[i] ^ flip_parity;

        // If the current effective value is 0, we need to perform an operation
        // starting at index i to make it 1.
        if (current_effective_value == 0) {
            operations++;
            // Performing an operation at index i flips nums[0]...nums[i].
            // This operation also changes the 'base state' (flip_parity) for all
            // subsequent elements nums[j] (where j > i).
            // So, we toggle flip_parity for future calculations.
            flip_parity = 1 - flip_parity;
        }
    }

    return operations;
}
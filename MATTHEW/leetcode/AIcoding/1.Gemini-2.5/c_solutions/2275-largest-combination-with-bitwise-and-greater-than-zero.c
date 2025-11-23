int largestCombination(int* candidates, int candidatesSize) {
    int max_count = 0;

    // Iterate through each bit position from 0 to 30 (as numbers are up to 10^7, which is less than 2^24,
    // so 30 bits cover all possible values for a standard 32-bit integer).
    for (int bit_pos = 0; bit_pos < 31; bit_pos++) {
        int current_bit_count = 0;

        // For the current bit position, count how many numbers in the array have this bit set.
        for (int i = 0; i < candidatesSize; i++) {
            // Check if the bit_pos-th bit is set in candidates[i]
            if ((candidates[i] >> bit_pos) & 1) {
                current_bit_count++;
            }
        }

        // Update the maximum count found so far.
        if (current_bit_count > max_count) {
            max_count = current_bit_count;
        }
    }

    return max_count;
}
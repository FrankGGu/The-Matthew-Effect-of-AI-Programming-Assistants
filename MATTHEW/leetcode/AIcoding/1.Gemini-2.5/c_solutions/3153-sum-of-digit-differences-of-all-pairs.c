long long sumDigitDifferences(int* nums, int numsSize) {
    long long total_sum_of_differences = 0;
    long long power_of_10 = 1;

    // Iterate through each digit position, from units place up to the 10th digit place (for numbers up to 10^9).
    // A number up to 10^9 has at most 10 digits (e.g., 1,000,000,000).
    // So, we need to check positions 0 through 9.
    for (int p = 0; p < 10; ++p) {
        int digit_counts[10] = {0}; // Array to store counts of each digit (0-9) for the current position 'p'

        // Extract the p-th digit for each number in nums and update its count
        for (int i = 0; i < numsSize; ++i) {
            int current_num = nums[i];
            int digit = (current_num / power_of_10) % 10;
            digit_counts[digit]++;
        }

        long long pairs_with_same_digit_at_p = 0;
        // Calculate the number of pairs that have the same digit at the current position 'p'.
        // If 'k' numbers have the same digit 'd' at position 'p', they form k * (k - 1) / 2 pairs.
        for (int d = 0; d < 10; ++d) {
            long long count_d = digit_counts[d];
            pairs_with_same_digit_at_p += count_d * (count_d - 1) / 2;
        }

        long long num_elements = numsSize;
        // Calculate the total number of unique pairs (i, j) where i < j.
        long long total_pairs = num_elements * (num_elements - 1) / 2;

        // The number of pairs with different digits at position 'p' is
        // (Total pairs) - (Pairs with same digit at position 'p').
        long long pairs_with_different_digit_at_p = total_pairs - pairs_with_same_digit_at_p;

        // Add this count to the overall sum of digit differences.
        total_sum_of_differences += pairs_with_different_digit_at_p;

        // Prepare for the next digit position by multiplying power_of_10 by 10.
        // We only need to do this if there are more positions to check.
        if (p < 9) { 
            power_of_10 *= 10;
        }
    }

    return total_sum_of_differences;
}
long long zeroFilledSubarrays(int* nums, int numsSize) {
    long long total_subarrays = 0;
    long long current_zero_count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            current_zero_count++;
        } else {
            // If current_zero_count is k, it contributes k*(k+1)/2 subarrays
            total_subarrays += (current_zero_count * (current_zero_count + 1)) / 2;
            current_zero_count = 0;
        }
    }

    // Add any remaining subarrays from a trailing sequence of zeros
    total_subarrays += (current_zero_count * (current_zero_count + 1)) / 2;

    return total_subarrays;
}
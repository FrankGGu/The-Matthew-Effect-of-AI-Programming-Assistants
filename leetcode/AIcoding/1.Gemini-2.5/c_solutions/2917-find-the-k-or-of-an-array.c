int findKOr(int* nums, int numsSize, int k) {
    int result = 0;
    for (int j = 0; j < 31; ++j) { // Iterate through bit positions from 0 to 30 (sufficient for numbers up to 10^9)
        int count = 0;
        for (int i = 0; i < numsSize; ++i) {
            if ((nums[i] >> j) & 1) { // Check if the j-th bit is set in nums[i]
                count++;
            }
        }
        if (count >= k) { // If at least k numbers have the j-th bit set
            result |= (1 << j); // Set the j-th bit in the result
        }
    }
    return result;
}
int maximumStrongPairXor(int* nums, int numsSize) {
    int max_xor = 0;

    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            int x = nums[i];
            int y = nums[j];

            int min_val = (x < y) ? x : y;
            int max_val = (x > y) ? x : y;

            // Check strong pair condition: max(x, y) <= 2 * min(x, y)
            if (max_val <= 2 * min_val) {
                int current_xor = x ^ y;
                if (current_xor > max_xor) {
                    max_xor = current_xor;
                }
            }
        }
    }

    return max_xor;
}
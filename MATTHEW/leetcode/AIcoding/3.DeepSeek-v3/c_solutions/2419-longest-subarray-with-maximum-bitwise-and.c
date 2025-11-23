int longestSubarray(int* nums, int numsSize) {
    int max_val = 0;
    int max_len = 0;
    int current_len = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
            max_len = 1;
            current_len = 1;
        } else if (nums[i] == max_val) {
            current_len++;
            if (current_len > max_len) {
                max_len = current_len;
            }
        } else {
            current_len = 0;
        }
    }

    return max_len;
}
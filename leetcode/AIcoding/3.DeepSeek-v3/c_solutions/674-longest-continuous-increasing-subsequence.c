int findLengthOfLCIS(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int max_len = 1;
    int current_len = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i-1]) {
            current_len++;
            if (current_len > max_len) {
                max_len = current_len;
            }
        } else {
            current_len = 1;
        }
    }

    return max_len;
}
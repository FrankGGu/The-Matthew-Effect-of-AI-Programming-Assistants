int longestMonotonicSubarray(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int max_len = 1;
    int inc_len = 1;
    int dec_len = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i-1]) {
            inc_len++;
            dec_len = 1;
        } else if (nums[i] < nums[i-1]) {
            dec_len++;
            inc_len = 1;
        } else {
            inc_len = 1;
            dec_len = 1;
        }

        if (inc_len > max_len) max_len = inc_len;
        if (dec_len > max_len) max_len = dec_len;
    }

    return max_len;
}
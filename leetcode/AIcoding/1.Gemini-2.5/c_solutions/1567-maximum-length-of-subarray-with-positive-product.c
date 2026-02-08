int getMaxLen(int* nums, int numsSize) {
    int current_pos = 0; // Max length of subarray ending at current index with positive product
    int current_neg = 0; // Max length of subarray ending at current index with negative product
    int max_len = 0;     // Overall maximum length found

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            current_pos = 0;
            current_neg = 0;
        } else if (nums[i] > 0) {
            current_pos++;
            if (current_neg > 0) {
                current_neg++;
            }
        } else { // nums[i] < 0
            int prev_pos_val = current_pos;

            current_pos = (current_neg > 0) ? current_neg + 1 : 0;
            current_neg = prev_pos_val + 1;
        }

        max_len = (max_len > current_pos) ? max_len : current_pos;
    }

    return max_len;
}
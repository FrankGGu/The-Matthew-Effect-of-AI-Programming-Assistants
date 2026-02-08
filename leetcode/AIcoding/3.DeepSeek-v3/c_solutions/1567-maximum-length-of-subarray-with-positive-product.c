int getMaxLen(int* nums, int numsSize) {
    int pos = 0, neg = 0;
    int max_len = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            pos = 0;
            neg = 0;
        } else if (nums[i] > 0) {
            pos++;
            if (neg > 0) neg++;
            if (pos > max_len) max_len = pos;
        } else {
            int temp = pos;
            pos = neg;
            neg = temp;
            neg++;
            if (pos > 0) pos++;
            if (pos > max_len) max_len = pos;
        }
    }

    return max_len;
}
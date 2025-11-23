int alternatingSubarray(int* nums, int numsSize) {
    int max_len = -1;
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i + 1] - nums[i] == 1) {
            int len = 2;
            for (int j = i + 2; j < numsSize; j++) {
                if (nums[j] - nums[j - 1] == ((j - i) % 2 == 0 ? 1 : -1)) {
                    len++;
                } else {
                    break;
                }
            }
            if (len > max_len) {
                max_len = len;
            }
        }
    }
    return max_len;
}
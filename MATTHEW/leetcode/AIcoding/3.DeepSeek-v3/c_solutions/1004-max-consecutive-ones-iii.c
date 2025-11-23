int longestOnes(int* nums, int numsSize, int k) {
    int left = 0, right = 0;
    int max_len = 0;
    int zero_count = 0;

    while (right < numsSize) {
        if (nums[right] == 0) {
            zero_count++;
        }

        while (zero_count > k) {
            if (nums[left] == 0) {
                zero_count--;
            }
            left++;
        }

        max_len = (right - left + 1 > max_len) ? right - left + 1 : max_len;
        right++;
    }

    return max_len;
}
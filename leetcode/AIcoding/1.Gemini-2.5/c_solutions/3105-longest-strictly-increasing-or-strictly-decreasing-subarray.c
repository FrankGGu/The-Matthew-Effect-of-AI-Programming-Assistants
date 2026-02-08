int longestSubarray(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return numsSize;
    }

    int max_len = 1;
    int current_increasing_len = 1;
    int current_decreasing_len = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i-1]) {
            current_increasing_len++;
            current_decreasing_len = 1; 
        } else if (nums[i] < nums[i-1]) {
            current_decreasing_len++;
            current_increasing_len = 1;
        } else { // nums[i] == nums[i-1]
            current_increasing_len = 1;
            current_decreasing_len = 1;
        }

        max_len = (max_len > current_increasing_len) ? max_len : current_increasing_len;
        max_len = (max_len > current_decreasing_len) ? max_len : current_decreasing_len;
    }

    return max_len;
}
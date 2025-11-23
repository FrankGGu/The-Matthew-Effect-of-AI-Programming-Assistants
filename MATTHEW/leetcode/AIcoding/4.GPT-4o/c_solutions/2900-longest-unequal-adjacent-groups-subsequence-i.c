int longestUnequalAdjacentGroups(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int max_length = 1, current_length = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[i - 1]) {
            current_length++;
        } else {
            if (current_length > max_length) {
                max_length = current_length;
            }
            current_length = 1;
        }
    }

    if (current_length > max_length) {
        max_length = current_length;
    }

    return max_length;
}
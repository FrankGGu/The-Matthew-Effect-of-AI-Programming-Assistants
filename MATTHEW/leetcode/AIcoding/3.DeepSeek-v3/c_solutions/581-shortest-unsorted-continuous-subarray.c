int findUnsortedSubarray(int* nums, int numsSize) {
    int left = -1, right = -1;
    int max_val = nums[0];
    int min_val = nums[numsSize - 1];

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < max_val) {
            right = i;
        } else {
            max_val = nums[i];
        }
    }

    for (int i = numsSize - 1; i >= 0; i--) {
        if (nums[i] > min_val) {
            left = i;
        } else {
            min_val = nums[i];
        }
    }

    return left == -1 ? 0 : right - left + 1;
}
int findMaxConsecutiveOnes(int* nums, int numsSize) {
    int max_so_far = 0;
    int current_max = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            current_max++;
        } else {
            if (current_max > max_so_far) {
                max_so_far = current_max;
            }
            current_max = 0;
        }
    }

    if (current_max > max_so_far) {
        max_so_far = current_max;
    }

    return max_so_far;
}
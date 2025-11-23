int identifyLargestOutlier(int* nums, int numsSize) {
    int first_is_even = (nums[0] % 2 == 0);
    int second_is_even = (nums[1] % 2 == 0);
    int third_is_even = (nums[2] % 2 == 0);

    int dominant_parity_is_even;

    if (first_is_even == second_is_even) {
        dominant_parity_is_even = first_is_even;
    } else {
        dominant_parity_is_even = third_is_even;
    }

    for (int i = 0; i < numsSize; i++) {
        int current_is_even = (nums[i] % 2 == 0);
        if (current_is_even != dominant_parity_is_even) {
            return nums[i];
        }
    }

    return -1;
}
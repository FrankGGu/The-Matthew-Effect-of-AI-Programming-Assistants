int minStartValue(int* nums, int numsSize) {
    int current_sum = 0;
    int min_prefix_sum = 0;

    for (int i = 0; i < numsSize; i++) {
        current_sum += nums[i];
        if (current_sum < min_prefix_sum) {
            min_prefix_sum = current_sum;
        }
    }

    return 1 - min_prefix_sum;
}
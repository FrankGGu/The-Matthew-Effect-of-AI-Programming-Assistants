int partitionDisjoint(int* nums, int numsSize) {
    int max_left_val = nums[0];
    int overall_max = nums[0];
    int partition_idx = 1;

    for (int i = 1; i < numsSize; i++) {
        overall_max = (overall_max > nums[i]) ? overall_max : nums[i];

        if (nums[i] < max_left_val) {
            partition_idx = i + 1;
            max_left_val = overall_max;
        }
    }

    return partition_idx;
}
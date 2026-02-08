int maxAbsoluteSum(int* nums, int numsSize) {
    int max_sum = 0, min_sum = 0;
    int cur_max = 0, cur_min = 0;

    for (int i = 0; i < numsSize; i++) {
        cur_max = (cur_max + nums[i] > nums[i]) ? cur_max + nums[i] : nums[i];
        cur_min = (cur_min + nums[i] < nums[i]) ? cur_min + nums[i] : nums[i];

        if (cur_max > max_sum) max_sum = cur_max;
        if (cur_min < min_sum) min_sum = cur_min;
    }

    return (abs(max_sum) > abs(min_sum)) ? abs(max_sum) : abs(min_sum);
}
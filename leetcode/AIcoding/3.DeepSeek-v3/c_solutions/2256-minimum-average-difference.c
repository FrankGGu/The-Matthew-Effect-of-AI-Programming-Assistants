int minimumAverageDifference(int* nums, int numsSize) {
    long long total_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        total_sum += nums[i];
    }

    long long left_sum = 0;
    int min_index = 0;
    long long min_avg_diff = LLONG_MAX;

    for (int i = 0; i < numsSize; i++) {
        left_sum += nums[i];
        long long right_sum = total_sum - left_sum;

        long long left_avg = left_sum / (i + 1);
        long long right_avg = (i == numsSize - 1) ? 0 : right_sum / (numsSize - i - 1);

        long long diff = llabs(left_avg - right_avg);

        if (diff < min_avg_diff) {
            min_avg_diff = diff;
            min_index = i;
        }
    }

    return min_index;
}
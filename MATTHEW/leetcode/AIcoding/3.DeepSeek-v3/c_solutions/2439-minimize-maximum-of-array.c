int minimizeArrayValue(int* nums, int numsSize) {
    long long prefix_sum = 0;
    long long result = 0;

    for (int i = 0; i < numsSize; i++) {
        prefix_sum += nums[i];
        long long current_max = (prefix_sum + i) / (i + 1);
        if (current_max > result) {
            result = current_max;
        }
    }

    return (int)result;
}
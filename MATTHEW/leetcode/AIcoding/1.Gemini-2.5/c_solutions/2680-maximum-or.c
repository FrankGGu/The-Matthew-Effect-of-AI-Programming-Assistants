long long maximumOr(int* nums, int numsSize, int k) {
    long long max_num = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_num) {
            max_num = nums[i];
        }
    }

    long long max_or_val = 0;

    for (int j = 0; j < numsSize; j++) {
        long long current_val_shifted = (long long)nums[j] << k;
        long long current_or_result = max_num | current_val_shifted;
        if (current_or_result > max_or_val) {
            max_or_val = current_or_result;
        }
    }

    return max_or_val;
}
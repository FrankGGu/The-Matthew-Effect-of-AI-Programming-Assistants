long long max(long long a, long long b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

long long maxSequenceValue(int* nums, int numsSize) {
    int min_val_i = nums[0];
    long long max_diff_j_minus_i = LLONG_MIN;
    long long max_sequence_value = LLONG_MIN;

    for (int idx = 1; idx < numsSize; ++idx) {
        if (max_diff_j_minus_i != LLONG_MIN) {
            max_sequence_value = max(max_sequence_value, max_diff_j_minus_i * nums[idx]);
        }

        long long current_potential_diff = (long long)nums[idx] - min_val_i;
        if (max_diff_j_minus_i == LLONG_MIN || current_potential_diff > max_diff_j_minus_i) {
            max_diff_j_minus_i = current_potential_diff;
        }

        min_val_i = min(min_val_i, nums[idx]);
    }

    return max_sequence_value;
}
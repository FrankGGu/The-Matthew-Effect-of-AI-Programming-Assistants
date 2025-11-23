long long countAlternatingSubarrays(int* nums, int numsSize) {
    long long total_count = 0;
    int current_alternating_length = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i == 0 || nums[i] != nums[i - 1]) {
            current_alternating_length++;
        } else {
            current_alternating_length = 1;
        }
        total_count += current_alternating_length;
    }

    return total_count;
}
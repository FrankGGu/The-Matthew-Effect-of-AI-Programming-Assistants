int maximumUniqueSubarray(int* nums, int numsSize) {
    int* count = (int*)calloc(10001, sizeof(int));
    int left = 0, right = 0;
    int current_sum = 0, max_sum = 0;

    while (right < numsSize) {
        count[nums[right]]++;
        current_sum += nums[right];

        while (count[nums[right]] > 1) {
            count[nums[left]]--;
            current_sum -= nums[left];
            left++;
        }

        if (current_sum > max_sum) {
            max_sum = current_sum;
        }

        right++;
    }

    free(count);
    return max_sum;
}
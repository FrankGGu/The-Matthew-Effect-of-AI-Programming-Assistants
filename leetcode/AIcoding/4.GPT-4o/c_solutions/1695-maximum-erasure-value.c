int maximumUniqueSubarray(int* nums, int numsSize) {
    int max_sum = 0, current_sum = 0;
    int hash[10001] = {0};
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        hash[nums[right]]++;
        current_sum += nums[right];

        while (hash[nums[right]] > 1) {
            hash[nums[left]]--;
            current_sum -= nums[left];
            left++;
        }

        if (current_sum > max_sum) {
            max_sum = current_sum;
        }
    }

    return max_sum;
}
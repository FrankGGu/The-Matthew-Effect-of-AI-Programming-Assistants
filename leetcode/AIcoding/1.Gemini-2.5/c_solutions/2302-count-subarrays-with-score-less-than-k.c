long long countSubarrays(int* nums, int numsSize, long long k) {
    long long count = 0;
    long long current_sum = 0;
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        current_sum += nums[right];

        while (current_sum * (right - left + 1) >= k) {
            current_sum -= nums[left];
            left++;
        }

        count += (right - left + 1);
    }

    return count;
}
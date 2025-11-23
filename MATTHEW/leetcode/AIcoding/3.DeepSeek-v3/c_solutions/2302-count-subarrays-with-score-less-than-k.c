long long countSubarrays(int* nums, int numsSize, long long k) {
    long long count = 0;
    long long sum = 0;
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        sum += nums[right];

        while (sum * (right - left + 1) >= k && left <= right) {
            sum -= nums[left];
            left++;
        }

        count += (right - left + 1);
    }

    return count;
}
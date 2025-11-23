int countSubarrays(int* nums, int numsSize, int k) {
    int count = 0, left = 0, sum = 0;
    for (int right = 0; right < numsSize; right++) {
        sum += nums[right];
        while (sum * (right - left + 1) >= k) {
            sum -= nums[left++];
        }
        count += right - left + 1;
    }
    return count;
}
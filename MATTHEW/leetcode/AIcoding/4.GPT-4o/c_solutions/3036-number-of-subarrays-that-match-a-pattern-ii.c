int numberOfSubarrays(int* nums, int numsSize, int k, int m) {
    int count = 0, left = 0, right = 0, currentCount = 0;
    while (right < numsSize) {
        if (nums[right] >= k && nums[right] <= m) {
            currentCount++;
        }
        while (currentCount > 0) {
            if (nums[left] >= k && nums[left] <= m) {
                currentCount--;
            }
            left++;
        }
        count += right - left + 1;
        right++;
    }
    return count;
}
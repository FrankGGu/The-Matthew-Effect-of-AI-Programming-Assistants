int minOperations(int* nums, int numsSize, int x) {
    int total = 0, target = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }
    target = total - x;
    if (target < 0) return -1;

    int maxLength = -1, currentSum = 0;
    for (int left = 0, right = 0; right < numsSize; right++) {
        currentSum += nums[right];
        while (currentSum > target && left <= right) {
            currentSum -= nums[left++];
        }
        if (currentSum == target) {
            maxLength = (maxLength > (right - left + 1)) ? maxLength : (right - left + 1);
        }
    }
    return maxLength == -1 ? -1 : numsSize - maxLength;
}
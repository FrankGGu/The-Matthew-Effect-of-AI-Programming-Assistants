int minOperations(int* nums, int numsSize, int x) {
    int total = 0, target = 0, len = -1;
    for (int i = 0; i < numsSize; i++) total += nums[i];
    target = total - x;

    if (target < 0) return -1;

    int left = 0, sum = 0;
    for (int right = 0; right < numsSize; right++) {
        sum += nums[right];
        while (sum > target) {
            sum -= nums[left++];
        }
        if (sum == target) {
            len = len < (right - left + 1) ? (right - left + 1) : len;
        }
    }

    return len == -1 ? -1 : numsSize - len;
}
int minOperations(int* nums, int numsSize, int x) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    int target = total - x;
    if (target < 0) return -1;
    if (target == 0) return numsSize;

    int left = 0, current = 0, max_len = -1;
    for (int right = 0; right < numsSize; right++) {
        current += nums[right];
        while (current > target && left <= right) {
            current -= nums[left];
            left++;
        }
        if (current == target) {
            max_len = (max_len > (right - left + 1)) ? max_len : (right - left + 1);
        }
    }

    return max_len == -1 ? -1 : numsSize - max_len;
}
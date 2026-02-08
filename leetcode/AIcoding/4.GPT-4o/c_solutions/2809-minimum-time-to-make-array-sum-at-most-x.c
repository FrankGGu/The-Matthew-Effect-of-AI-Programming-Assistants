int minTime(int* nums, int numsSize, int x) {
    int total = 0, minLen = numsSize + 1, currSum = 0;
    for (int i = 0; i < numsSize; i++) total += nums[i];
    int target = total - x;

    if (target < 0) return -1;

    for (int left = 0, right = 0; right < numsSize; right++) {
        currSum += nums[right];
        while (currSum > target) {
            currSum -= nums[left++];
        }
        if (currSum == target) {
            minLen = fmin(minLen, right - left + 1);
        }
    }
    return minLen == numsSize + 1 ? -1 : minLen;
}
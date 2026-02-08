int longestUnequalAdjGroups(int* nums, int numsSize) {
    int count = 1;
    int maxCount = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] != nums[i - 1]) {
            count++;
        } else {
            maxCount = count > maxCount ? count : maxCount;
            count = 1;
        }
    }

    maxCount = count > maxCount ? count : maxCount;
    return maxCount;
}
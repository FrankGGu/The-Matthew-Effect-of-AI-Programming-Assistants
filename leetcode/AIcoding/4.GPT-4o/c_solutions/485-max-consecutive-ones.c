int findMaxConsecutiveOnes(int* nums, int numsSize) {
    int maxCount = 0, currentCount = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            currentCount++;
        } else {
            if (currentCount > maxCount) {
                maxCount = currentCount;
            }
            currentCount = 0;
        }
    }
    return currentCount > maxCount ? currentCount : maxCount;
}
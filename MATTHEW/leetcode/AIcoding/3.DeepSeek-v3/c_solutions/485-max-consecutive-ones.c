int findMaxConsecutiveOnes(int* nums, int numsSize) {
    int maxCount = 0;
    int currentCount = 0;

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

    if (currentCount > maxCount) {
        maxCount = currentCount;
    }

    return maxCount;
}
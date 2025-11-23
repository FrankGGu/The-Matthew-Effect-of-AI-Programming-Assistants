int maximumDifference(int* nums, int numsSize) {
    int maxDiff = -1;
    int minElement = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > minElement) {
            int currentDiff = nums[i] - minElement;
            if (currentDiff > maxDiff) {
                maxDiff = currentDiff;
            }
        } else {
            minElement = nums[i];
        }
    }

    return maxDiff;
}
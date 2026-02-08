int maximumDifference(int* nums, int numsSize) {
    int maxDiff = -1;
    int minValue = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > minValue) {
            int diff = nums[i] - minValue;
            if (diff > maxDiff) {
                maxDiff = diff;
            }
        } else {
            minValue = nums[i];
        }
    }

    return maxDiff;
}
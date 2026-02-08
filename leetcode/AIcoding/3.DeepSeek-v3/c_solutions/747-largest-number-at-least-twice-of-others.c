int dominantIndex(int* nums, int numsSize) {
    if (numsSize == 1) return 0;

    int maxIndex = 0;
    int secondMax = -1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[maxIndex]) {
            secondMax = nums[maxIndex];
            maxIndex = i;
        } else if (secondMax == -1 || nums[i] > secondMax) {
            secondMax = nums[i];
        }
    }

    return (nums[maxIndex] >= 2 * secondMax) ? maxIndex : -1;
}
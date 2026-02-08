int maxAdjacentDifference(int* nums, int numsSize) {
    int maxDiff = 0;
    for (int i = 0; i < numsSize; i++) {
        int diff = abs(nums[i] - nums[(i + 1) % numsSize]);
        if (diff > maxDiff) {
            maxDiff = diff;
        }
    }
    return maxDiff;
}
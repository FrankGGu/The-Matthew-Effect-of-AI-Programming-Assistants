bool hasAdjacentIncreasingSubarrays(int* nums, int numsSize) {
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i - 1]) {
            if (i > 1 && nums[i - 1] > nums[i - 2]) {
                return true;
            }
        }
    }
    return false;
}
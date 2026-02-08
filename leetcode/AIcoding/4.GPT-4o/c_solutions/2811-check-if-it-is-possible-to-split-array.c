bool canSplitArray(int* nums, int numsSize) {
    if (numsSize < 2) return true;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] + nums[i - 1] < 4) {
            return false;
        }
    }
    return true;
}
int minimumArray(int* nums, int numsSize) {
    int minEnd = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < minEnd) {
            minEnd = nums[i];
        }
    }
    return minEnd;
}
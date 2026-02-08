int partitionArray(int* nums, int numsSize) {
    int maxLeft = nums[0], partitionIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < maxLeft) {
            partitionIndex = i;
        } else {
            maxLeft = fmax(maxLeft, nums[i]);
        }
    }
    return partitionIndex + 1;
}
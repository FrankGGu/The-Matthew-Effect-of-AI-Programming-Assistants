int partitionDisjoint(int* nums, int numsSize) {
    int leftMax = nums[0];
    int curMax = nums[0];
    int partitionIdx = 0;

    for (int i = 1; i < numsSize; i++) {
        curMax = (nums[i] > curMax) ? nums[i] : curMax;
        if (nums[i] < leftMax) {
            leftMax = curMax;
            partitionIdx = i;
        }
    }

    return partitionIdx + 1;
}
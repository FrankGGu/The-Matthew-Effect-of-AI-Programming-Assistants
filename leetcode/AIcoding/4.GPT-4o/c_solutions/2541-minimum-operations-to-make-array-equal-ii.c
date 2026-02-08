int minOperations(int* nums, int numsSize) {
    int min = nums[0], max = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min) min = nums[i];
        if (nums[i] > max) max = nums[i];
    }
    return (max - min) / 2 + (max - min) % 2;
}
int maxValue(int* nums, int numsSize) {
    int max1 = -1000000000, max2 = -1000000000;
    int min1 = 1000000000, min2 = 1000000000;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] + i > max1) max1 = nums[i] + i;
        if (nums[i] + i < min1) min1 = nums[i] + i;
        if (nums[i] - i > max2) max2 = nums[i] - i;
        if (nums[i] - i < min2) min2 = nums[i] - i;
    }

    return (max1 - min1) > (max2 - min2) ? (max1 - min1) : (max2 - min2);
}
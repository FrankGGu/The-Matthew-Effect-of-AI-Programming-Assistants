int maxProductDifference(int* nums, int numsSize) {
    int max1 = 0, max2 = 0, min1 = 0, min2 = 0;
    if (nums[0] > nums[1]) {
        max1 = nums[0]; max2 = nums[1];
        min1 = nums[1]; min2 = nums[0];
    } else {
        max1 = nums[1]; max2 = nums[0];
        min1 = nums[0]; min2 = nums[1];
    }

    for (int i = 2; i < numsSize; i++) {
        if (nums[i] > max1) {
            max2 = max1;
            max1 = nums[i];
        } else if (nums[i] > max2) {
            max2 = nums[i];
        }

        if (nums[i] < min1) {
            min2 = min1;
            min1 = nums[i];
        } else if (nums[i] < min2) {
            min2 = nums[i];
        }
    }

    return (max1 * max2) - (min1 * min2);
}
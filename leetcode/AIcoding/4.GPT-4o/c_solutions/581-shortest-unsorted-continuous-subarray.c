int findUnsortedSubarray(int* nums, int numsSize) {
    int start = numsSize, end = 0;
    int max = nums[0], min = nums[numsSize - 1];

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < max) end = i;
        max = nums[i] > max ? nums[i] : max;

        if (nums[numsSize - 1 - i] > min) start = numsSize - 1 - i;
        min = nums[numsSize - 1 - i] < min ? nums[numsSize - 1 - i] : min;
    }

    return end - start > 0 ? end - start + 1 : 0;
}
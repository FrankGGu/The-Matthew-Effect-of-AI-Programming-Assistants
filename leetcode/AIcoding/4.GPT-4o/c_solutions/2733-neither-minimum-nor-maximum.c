int findNonMinOrMax(int* nums, int numsSize) {
    if (numsSize < 3) return -1;
    int min = INT_MAX, max = INT_MIN;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < min) min = nums[i];
        if (nums[i] > max) max = nums[i];
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > min && nums[i] < max) return nums[i];
    }

    return -1;
}
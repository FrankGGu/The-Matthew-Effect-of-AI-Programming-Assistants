int countElements(int* nums, int numsSize) {
    if (numsSize < 3) return 0;

    int min = nums[0], max = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min) min = nums[i];
        if (nums[i] > max) max = nums[i];
    }

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > min && nums[i] < max) count++;
    }

    return count;
}
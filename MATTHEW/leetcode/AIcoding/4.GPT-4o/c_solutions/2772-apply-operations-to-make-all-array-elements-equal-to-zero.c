int applyOperations(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            count++;
        }
    }
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] != 0 && nums[i] == nums[i + 1]) {
            nums[count++] = nums[i] * 2;
            i++;
        } else if (nums[i] != 0) {
            nums[count++] = nums[i];
        }
    }
    for (int i = count; i < numsSize; i++) {
        nums[i] = 0;
    }
    return numsSize;
}
int minimumRightShifts(int* nums, int numsSize) {
    int pivot = -1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[i-1]) {
            pivot = i;
            break;
        }
    }

    if (pivot == -1) return 0;

    for (int i = pivot + 1; i < numsSize; i++) {
        if (nums[i] < nums[i-1]) {
            return -1;
        }
    }

    if (nums[numsSize-1] <= nums[0]) {
        return numsSize - pivot;
    }

    return -1;
}
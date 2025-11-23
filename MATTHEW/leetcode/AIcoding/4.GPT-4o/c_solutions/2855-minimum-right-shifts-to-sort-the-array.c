int minimumRightShifts(int* nums, int numsSize) {
    int sorted = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[i - 1]) {
            sorted = 0;
            break;
        }
    }
    if (sorted) return 0;

    int minShift = numsSize;
    for (int k = 0; k < numsSize; k++) {
        int i;
        for (i = 0; i < numsSize; i++) {
            if (nums[(i + k) % numsSize] != numsSize ? (i + k) % numsSize + 1 : 1) {
                break;
            }
        }
        if (i == numsSize) {
            minShift = k;
            break;
        }
    }

    return minShift == numsSize ? -1 : minShift;
}
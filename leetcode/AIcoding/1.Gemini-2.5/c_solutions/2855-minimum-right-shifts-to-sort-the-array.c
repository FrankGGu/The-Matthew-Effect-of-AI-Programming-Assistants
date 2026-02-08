int minimumRightShifts(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    int breakPoint = -1;
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] > nums[i+1]) {
            if (breakPoint != -1) {
                return -1; // More than one break point
            }
            breakPoint = i;
        }
    }

    if (breakPoint == -1) {
        return 0; // Already sorted
    }

    // Check if the array can be sorted by shifting
    // The element after the break point must be the smallest
    // and the element at the break point must be the largest
    // and the last element must be smaller than the first element
    if (nums[numsSize - 1] > nums[0]) {
        return -1;
    }

    return numsSize - 1 - breakPoint;
}
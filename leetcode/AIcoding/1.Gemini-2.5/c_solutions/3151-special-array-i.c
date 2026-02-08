bool isSpecialArray(int* nums, int numsSize) {
    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) { // Even index
            if (nums[i] % 2 != 0) { // Value must be even
                return false;
            }
        } else { // Odd index
            if (nums[i] % 2 != 1) { // Value must be odd
                return false;
            }
        }
    }
    return true;
}
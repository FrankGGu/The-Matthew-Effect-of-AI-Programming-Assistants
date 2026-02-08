bool hasTrailingZeros(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if ((nums[i] & 1) == 0) {
            count++;
            if (count >= 2) {
                return true;
            }
        }
    }
    return false;
}
int minImpossibleOR(int* nums, int numsSize) {
    int mask = 0;
    for (int i = 0; i < numsSize; i++) {
        if ((nums[i] & (nums[i] - 1)) == 0) {
            mask |= nums[i];
        }
    }

    int result = 1;
    while (mask & result) {
        result <<= 1;
    }
    return result;
}
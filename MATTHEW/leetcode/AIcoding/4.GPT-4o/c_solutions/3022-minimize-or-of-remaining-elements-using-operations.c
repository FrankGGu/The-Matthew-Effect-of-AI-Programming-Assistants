int minimizeOr(int* nums, int numsSize) {
    int result = 0;
    int maxNum = 0;
    for (int i = 0; i < numsSize; i++) {
        maxNum |= nums[i];
    }
    for (int i = 0; i < numsSize; i++) {
        result |= maxNum & ~nums[i];
    }
    return result;
}
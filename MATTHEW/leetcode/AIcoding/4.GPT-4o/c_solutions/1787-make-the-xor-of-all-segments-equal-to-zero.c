bool xorSegmentsEqualToZero(int* nums, int numsSize) {
    int totalXor = 0;
    for (int i = 0; i < numsSize; i++) {
        totalXor ^= nums[i];
    }
    return totalXor == 0;
}
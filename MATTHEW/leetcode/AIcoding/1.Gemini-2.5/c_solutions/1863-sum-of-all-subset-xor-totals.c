int subsetXORSum(int* nums, int numsSize) {
    int or_total = 0;
    for (int i = 0; i < numsSize; i++) {
        or_total |= nums[i];
    }
    return or_total * (1 << (numsSize - 1));
}
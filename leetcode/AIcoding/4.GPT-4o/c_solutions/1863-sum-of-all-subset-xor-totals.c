int subsetXORSum(int* nums, int numsSize) {
    int totalSubsets = 1 << numsSize;
    int totalXORSum = 0;

    for (int i = 0; i < totalSubsets; i++) {
        int currentXOR = 0;
        for (int j = 0; j < numsSize; j++) {
            if (i & (1 << j)) {
                currentXOR ^= nums[j];
            }
        }
        totalXORSum += currentXOR;
    }

    return totalXORSum;
}
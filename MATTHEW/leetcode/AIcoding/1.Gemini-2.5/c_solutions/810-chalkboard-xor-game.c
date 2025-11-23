int xorGame(int* nums, int numsSize) {
    if (numsSize % 2 == 0) {
        return 1;
    }

    int xorSum = 0;
    for (int i = 0; i < numsSize; i++) {
        xorSum ^= nums[i];
    }

    return xorSum == 0;
}
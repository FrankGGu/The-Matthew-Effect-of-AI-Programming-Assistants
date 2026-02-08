int maxSubarrays(int* nums, int numsSize) {
    int totalAnd = -1;
    for (int i = 0; i < numsSize; i++) {
        totalAnd &= nums[i];
    }

    if (totalAnd != 0) {
        return 1;
    }

    int count = 0;
    int currentAnd = -1;
    for (int i = 0; i < numsSize; i++) {
        currentAnd &= nums[i];
        if (currentAnd == 0) {
            count++;
            currentAnd = -1;
        }
    }

    return count > 1 ? count : 1;
}
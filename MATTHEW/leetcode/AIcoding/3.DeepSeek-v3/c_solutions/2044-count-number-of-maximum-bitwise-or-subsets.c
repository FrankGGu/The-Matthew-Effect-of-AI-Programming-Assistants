int countMaxOrSubsets(int* nums, int numsSize) {
    int maxOr = 0;
    for (int i = 0; i < numsSize; i++) {
        maxOr |= nums[i];
    }

    int count = 0;
    int total = 1 << numsSize;

    for (int mask = 1; mask < total; mask++) {
        int currentOr = 0;
        for (int i = 0; i < numsSize; i++) {
            if (mask & (1 << i)) {
                currentOr |= nums[i];
            }
        }
        if (currentOr == maxOr) {
            count++;
        }
    }

    return count;
}
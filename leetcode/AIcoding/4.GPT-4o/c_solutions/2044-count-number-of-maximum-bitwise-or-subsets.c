int countMaxOrSubsets(int* nums, int numsSize) {
    int maxOr = 0, count = 0;

    for (int i = 0; i < numsSize; i++) {
        maxOr |= nums[i];
    }

    for (int i = 0; i < (1 << numsSize); i++) {
        int currentOr = 0;
        for (int j = 0; j < numsSize; j++) {
            if (i & (1 << j)) {
                currentOr |= nums[j];
            }
        }
        if (currentOr == maxOr) {
            count++;
        }
    }

    return count;
}
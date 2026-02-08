int maxSubarrays(int* nums, int numsSize) {
    int total_and = -1;
    for (int i = 0; i < numsSize; i++) {
        total_and &= nums[i];
    }

    if (total_and != 0) {
        return 1;
    }

    int count = 0;
    int current_and = -1;
    for (int i = 0; i < numsSize; i++) {
        current_and &= nums[i];
        if (current_and == 0) {
            count++;
            current_and = -1;
        }
    }

    return count;
}
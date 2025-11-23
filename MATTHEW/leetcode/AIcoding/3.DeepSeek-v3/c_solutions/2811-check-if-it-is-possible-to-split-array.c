int canSplit(int* nums, int numsSize, int m) {
    if (numsSize <= 2) return 1;

    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] + nums[i + 1] >= m) {
            return 1;
        }
    }

    return 0;
}
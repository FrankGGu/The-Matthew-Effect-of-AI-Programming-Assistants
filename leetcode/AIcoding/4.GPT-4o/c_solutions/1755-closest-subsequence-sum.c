int closestSubsequenceSum(int* nums, int numsSize, int goal) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }
    int limit = 1 << numsSize;
    int closest = total + 1;

    for (int i = 0; i < limit; i++) {
        int sum = 0;
        for (int j = 0; j < numsSize; j++) {
            if (i & (1 << j)) {
                sum += nums[j];
            }
        }
        if (abs(sum - goal) < abs(closest - goal)) {
            closest = sum;
        }
    }

    return closest;
}
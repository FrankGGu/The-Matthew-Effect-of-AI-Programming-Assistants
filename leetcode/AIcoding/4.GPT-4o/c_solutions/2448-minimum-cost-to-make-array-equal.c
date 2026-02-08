int minCost(int* nums, int numsSize, int x) {
    long total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }
    long minCost = total;
    for (int i = 0; i < numsSize; i++) {
        long currentCost = total - nums[i] + (long)x * i;
        if (currentCost < minCost) {
            minCost = currentCost;
        }
    }
    return (int)(minCost);
}
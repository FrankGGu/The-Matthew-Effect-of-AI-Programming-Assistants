int minCost(int* nums, int numsSize) {
    int sum = 0, minCost = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    int avg = sum / numsSize;
    for (int i = 0; i < numsSize; i++) {
        minCost += abs(nums[i] - avg);
    }
    return minCost;
}
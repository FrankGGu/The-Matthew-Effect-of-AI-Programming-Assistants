int minimumCost(int* nums, int numsSize) {
    if (numsSize < 3) return nums[0] + nums[1];

    int min_cost = INT_MAX;
    for (int i = 1; i < numsSize - 1; i++) {
        int cost = nums[0] + nums[i] + nums[i + 1];
        if (cost < min_cost) {
            min_cost = cost;
        }
    }
    return min_cost;
}
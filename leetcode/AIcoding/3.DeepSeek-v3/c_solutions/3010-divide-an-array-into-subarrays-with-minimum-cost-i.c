int minimumCost(int* nums, int numsSize) {
    int min_cost = INT_MAX;
    for (int i = 1; i < numsSize - 1; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int cost = nums[0] + nums[i] + nums[j];
            if (cost < min_cost) {
                min_cost = cost;
            }
        }
    }
    return min_cost;
}
int minOperations(int* nums, int numsSize, int target) {
    int cost = 0;
    for (int i = 0; i < numsSize; i++) {
        cost += abs(nums[i] - target);
    }
    return cost;
}
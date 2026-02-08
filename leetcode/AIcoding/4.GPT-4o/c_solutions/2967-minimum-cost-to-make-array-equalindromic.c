int minCost(int* nums, int numsSize) {
    int left = 0, right = numsSize - 1;
    int cost = 0;

    while (left < right) {
        cost += abs(nums[left] - nums[right]);
        left++;
        right--;
    }

    return cost;
}
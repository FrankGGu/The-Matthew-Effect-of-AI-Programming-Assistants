int findMinCost(int* nums, int numsSize, int* cost, int costSize) {
    long left = 0, right = 1e6, ans = 0;
    while (left <= right) {
        long mid = left + (right - left) / 2;
        long totalCost = 0;
        for (int i = 0; i < numsSize; i++) {
            totalCost += cost[i] * abs(nums[i] - mid);
        }
        if (totalCost > ans) {
            ans = totalCost;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return ans;
}
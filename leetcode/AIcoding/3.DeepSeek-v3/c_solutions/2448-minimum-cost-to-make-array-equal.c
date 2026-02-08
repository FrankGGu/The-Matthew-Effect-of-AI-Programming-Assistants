long long minCost(int* nums, int numsSize, int* cost, int costSize) {
    long long totalCost = 0;
    long long leftCost = 0;
    long long rightCost = 0;

    int minVal = nums[0];
    int maxVal = nums[0];
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < minVal) minVal = nums[i];
        if (nums[i] > maxVal) maxVal = nums[i];
    }

    while (minVal < maxVal) {
        int mid = minVal + (maxVal - minVal) / 2;

        leftCost = 0;
        rightCost = 0;
        for (int i = 0; i < numsSize; i++) {
            if (nums[i] <= mid) {
                leftCost += (long long)cost[i] * (mid - nums[i]);
            } else {
                rightCost += (long long)cost[i] * (nums[i] - mid);
            }
        }

        totalCost = leftCost + rightCost;

        if (leftCost < rightCost) {
            minVal = mid + 1;
        } else {
            maxVal = mid;
        }
    }

    long long result = 0;
    for (int i = 0; i < numsSize; i++) {
        result += (long long)cost[i] * llabs((long long)nums[i] - minVal);
    }

    return result;
}
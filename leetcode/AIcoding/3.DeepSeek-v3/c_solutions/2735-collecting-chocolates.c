int minCost(int* nums, int numsSize, int x) {
    long long res = 1e18;
    int n = numsSize;
    int minCost[n];
    for (int i = 0; i < n; i++) {
        minCost[i] = nums[i];
    }

    for (int k = 0; k < n; k++) {
        long long total = (long long)k * x;
        for (int i = 0; i < n; i++) {
            minCost[i] = (minCost[i] < nums[(i + k) % n]) ? minCost[i] : nums[(i + k) % n];
            total += minCost[i];
        }
        if (total < res) res = total;
    }

    return (int)res;
}
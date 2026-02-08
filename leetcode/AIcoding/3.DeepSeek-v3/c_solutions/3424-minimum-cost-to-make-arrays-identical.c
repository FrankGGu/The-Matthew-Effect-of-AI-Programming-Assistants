int minCost(int* nums, int numsSize, int* target, int targetSize, long long k) {
    long long diff = 0;
    for (int i = 0; i < numsSize; i++) {
        diff += abs(nums[i] - target[i]);
    }
    return (diff <= k) ? 0 : (int)(diff - k + 1) / 2;
}
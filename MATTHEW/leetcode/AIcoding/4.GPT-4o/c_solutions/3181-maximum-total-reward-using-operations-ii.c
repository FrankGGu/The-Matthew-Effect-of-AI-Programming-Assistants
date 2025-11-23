int maximumReward(int* nums, int numsSize, int k) {
    int maxReward = 0;
    int currentReward = 0;

    for (int i = 0; i < numsSize; i++) {
        currentReward += nums[i];
        if (i >= k) {
            currentReward -= nums[i - k];
        }
        if (i >= k - 1) {
            maxReward = (currentReward > maxReward) ? currentReward : maxReward;
        }
    }

    return maxReward;
}
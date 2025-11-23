int sumImbalanceNumbers(int* nums, int numsSize) {
    long long totalImbalance = 0;
    for (int i = 0; i < numsSize; i++) {
        int maxCount = 0, minCount = 0;
        int count[100001] = {0};
        for (int j = i; j < numsSize; j++) {
            count[nums[j]]++;
            if (count[nums[j]] == 1) {
                minCount++;
            }
            if (count[nums[j]] == 2) {
                minCount--;
            }
            if (++maxCount > 1) {
                totalImbalance += minCount;
            }
        }
    }
    return totalImbalance;
}
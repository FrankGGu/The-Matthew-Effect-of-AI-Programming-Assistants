int sumIndicesWithKSetBits(int* nums, int numsSize, int k) {
    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        int currentIdx = i;
        int setBitsCount = 0;
        while (currentIdx > 0) {
            currentIdx &= (currentIdx - 1);
            setBitsCount++;
        }

        if (setBitsCount == k) {
            totalSum += nums[i];
        }
    }
    return totalSum;
}
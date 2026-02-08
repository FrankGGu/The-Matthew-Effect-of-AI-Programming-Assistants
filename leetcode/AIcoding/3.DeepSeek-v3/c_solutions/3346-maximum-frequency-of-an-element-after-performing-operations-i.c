int maxFrequency(int* nums, int numsSize, int k, int numOperations) {
    int maxFreq = 0;
    int currentFreq;
    int operationsUsed;

    for (int i = 0; i < numsSize; i++) {
        currentFreq = 1;
        operationsUsed = 0;

        for (int j = 0; j < numsSize; j++) {
            if (i == j) continue;

            int diff = nums[i] - nums[j];
            if (diff >= 0 && diff <= k && operationsUsed + diff <= numOperations) {
                currentFreq++;
                operationsUsed += diff;
            }
        }

        if (currentFreq > maxFreq) {
            maxFreq = currentFreq;
        }
    }

    return maxFreq;
}
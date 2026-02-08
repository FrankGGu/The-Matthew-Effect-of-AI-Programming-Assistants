int countCompleteSubarrays(int* nums, int numsSize) {
    int count = 0, completeCount = 0;
    int freq[100001] = {0};

    for (int i = 0; i < numsSize; i++) {
        if (freq[nums[i]]++ == 0) {
            completeCount++;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        int uniqueCount = 0;
        int tempFreq[100001] = {0};

        for (int j = i; j < numsSize; j++) {
            if (tempFreq[nums[j]]++ == 0) {
                uniqueCount++;
            }
            if (uniqueCount == completeCount) {
                count++;
            }
        }
    }

    return count;
}
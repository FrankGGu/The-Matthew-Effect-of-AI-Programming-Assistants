int maximumFrequencyScore(int* nums, int numsSize, int* operations, int operationsSize) {
    int freq[100001] = {0}, maxFreq = 0;

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
        if (freq[nums[i]] > maxFreq) {
            maxFreq = freq[nums[i]];
        }
    }

    for (int i = 0; i < operationsSize; i++) {
        freq[operations[i]]++;
        if (freq[operations[i]] > maxFreq) {
            maxFreq = freq[operations[i]];
        }
    }

    return maxFreq;
}
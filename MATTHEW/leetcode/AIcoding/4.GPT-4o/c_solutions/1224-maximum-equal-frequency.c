int maxEqualFreq(int* nums, int numsSize) {
    int count[100001] = {0}, freq[100001] = {0}, maxFreq = 0, uniqueFreq = 0, maxEqual = 0;

    for (int i = 0; i < numsSize; i++) {
        if (count[nums[i]]++ == 0) uniqueFreq++;
        freq[count[nums[i]]]++;
        if (count[nums[i]] > 1) freq[count[nums[i]] - 1]--;
        maxFreq = maxFreq < count[nums[i]] ? count[nums[i]] : maxFreq;

        if (uniqueFreq == 1 || (uniqueFreq == 2 && (freq[1] == 1 || freq[maxFreq] * maxFreq == i + 1 - freq[1]))) {
            maxEqual = i + 1;
        }
    }
    return maxEqual;
}
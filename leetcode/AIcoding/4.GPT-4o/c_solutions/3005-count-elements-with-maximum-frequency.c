int countMaxFrequency(int* nums, int numsSize) {
    int count[100001] = {0};
    int maxFreq = 0;
    for (int i = 0; i < numsSize; i++) {
        count[nums[i]]++;
        if (count[nums[i]] > maxFreq) {
            maxFreq = count[nums[i]];
        }
    }
    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        if (count[nums[i]] == maxFreq) {
            result++;
        }
    }
    return result;
}
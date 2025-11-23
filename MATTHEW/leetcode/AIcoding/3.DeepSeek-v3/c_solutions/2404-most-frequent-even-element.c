int mostFrequentEven(int* nums, int numsSize) {
    int freq[100001] = {0};
    int maxFreq = 0;
    int result = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            freq[nums[i]]++;
            if (freq[nums[i]] > maxFreq || 
                (freq[nums[i]] == maxFreq && nums[i] < result)) {
                maxFreq = freq[nums[i]];
                result = nums[i];
            }
        }
    }

    return result;
}
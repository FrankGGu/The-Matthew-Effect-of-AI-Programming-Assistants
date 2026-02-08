int mostFrequentEven(int* nums, int numsSize) {
    int freq[1001] = {0}; 

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            freq[nums[i]]++;
        }
    }

    int max_freq = 0;
    int result = -1;

    for (int i = 0; i <= 1000; i++) {
        if (freq[i] > max_freq) {
            max_freq = freq[i];
            result = i;
        }
    }

    return result;
}
int mostFrequentEven(int* nums, int numsSize) {
    int frequency[10001] = {0};
    int max_freq = 0;
    int result = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            frequency[nums[i]]++;
            if (frequency[nums[i]] > max_freq || (frequency[nums[i]] == max_freq && nums[i] < result)) {
                max_freq = frequency[nums[i]];
                result = nums[i];
            }
        }
    }

    return result;
}
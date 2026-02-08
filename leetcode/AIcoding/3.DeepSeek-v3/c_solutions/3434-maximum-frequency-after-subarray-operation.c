int maxFrequency(int* nums, int numsSize, int k) {
    long long left = 0, right = 0;
    long long total = 0;
    int maxFreq = 0;

    for (right = 0; right < numsSize; right++) {
        total += nums[right];

        while ((right - left + 1) * nums[right] - total > k) {
            total -= nums[left];
            left++;
        }

        maxFreq = (right - left + 1) > maxFreq ? (right - left + 1) : maxFreq;
    }

    return maxFreq;
}
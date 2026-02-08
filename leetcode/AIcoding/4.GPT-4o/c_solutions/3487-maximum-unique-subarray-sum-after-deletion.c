int maximumUniqueSubarray(int* nums, int numsSize) {
    int maxSum = 0, currentSum = 0;
    int start = 0;
    int freq[10001] = {0};

    for (int end = 0; end < numsSize; end++) {
        currentSum += nums[end];
        freq[nums[end]]++;

        while (freq[nums[end]] > 1) {
            freq[nums[start]]--;
            currentSum -= nums[start];
            start++;
        }

        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }

    return maxSum;
}
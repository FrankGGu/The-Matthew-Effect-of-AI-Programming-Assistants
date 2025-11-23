int maximumSubarraySum(int* nums, int numsSize, int k) {
    long long maxSum = 0;
    long long currentSum = 0;
    int left = 0;
    int* freq = (int*)calloc(100001, sizeof(int));
    int duplicateCount = 0;

    for (int right = 0; right < numsSize; right++) {
        currentSum += nums[right];
        freq[nums[right]]++;
        if (freq[nums[right]] == 2) {
            duplicateCount++;
        }

        if (right - left + 1 > k) {
            currentSum -= nums[left];
            freq[nums[left]]--;
            if (freq[nums[left]] == 1) {
                duplicateCount--;
            }
            left++;
        }

        if (right - left + 1 == k && duplicateCount == 0) {
            if (currentSum > maxSum) {
                maxSum = currentSum;
            }
        }
    }

    free(freq);
    return maxSum;
}
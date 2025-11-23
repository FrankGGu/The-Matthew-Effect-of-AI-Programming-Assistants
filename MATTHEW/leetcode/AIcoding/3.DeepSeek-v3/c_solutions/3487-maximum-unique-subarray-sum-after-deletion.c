int maxSum(int* nums, int numsSize) {
    int freq[10001] = {0};
    int sum = 0;
    int maxSum = 0;
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        freq[nums[right]]++;
        sum += nums[right];

        while (freq[nums[right]] > 1) {
            freq[nums[left]]--;
            sum -= nums[left];
            left++;
        }

        if (sum > maxSum) {
            maxSum = sum;
        }
    }

    return maxSum;
}
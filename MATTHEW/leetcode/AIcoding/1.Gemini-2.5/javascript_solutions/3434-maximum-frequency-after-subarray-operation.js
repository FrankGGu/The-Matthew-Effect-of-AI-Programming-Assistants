var maxFrequency = function(nums, k) {
    nums.sort((a, b) => a - b);

    let left = 0;
    let currentSum = 0;
    let maxFreq = 0;

    for (let right = 0; right < nums.length; right++) {
        currentSum += nums[right];

        // The cost to make all elements in the window [left...right] equal to nums[right]
        // is (window_size * nums[right]) - currentSum.
        // window_size is (right - left + 1).
        // If this cost exceeds k, we need to shrink the window from the left.
        while ((right - left + 1) * nums[right] - currentSum > k) {
            currentSum -= nums[left];
            left++;
        }

        // The current window [left...right] is valid. Update maxFreq.
        maxFreq = Math.max(maxFreq, right - left + 1);
    }

    return maxFreq;
};
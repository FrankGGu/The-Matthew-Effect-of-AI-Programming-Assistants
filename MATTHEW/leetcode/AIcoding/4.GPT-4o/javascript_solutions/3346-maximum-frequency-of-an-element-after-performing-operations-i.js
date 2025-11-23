var maxFrequency = function(nums, k) {
    nums.sort((a, b) => a - b);
    let left = 0, total = 0, maxFreq = 0;

    for (let right = 0; right < nums.length; right++) {
        total += nums[right];

        while (nums[right] * (right - left + 1) > total + k) {
            total -= nums[left];
            left++;
        }

        maxFreq = Math.max(maxFreq, right - left + 1);
    }

    return maxFreq;
};
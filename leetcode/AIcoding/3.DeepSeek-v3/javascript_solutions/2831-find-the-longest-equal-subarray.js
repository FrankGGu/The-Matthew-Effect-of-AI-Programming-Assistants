var longestEqualSubarray = function(nums, k) {
    const freq = {};
    let maxFreq = 0;
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        const num = nums[right];
        freq[num] = (freq[num] || 0) + 1;
        maxFreq = Math.max(maxFreq, freq[num]);

        if (right - left + 1 - maxFreq > k) {
            freq[nums[left]]--;
            left++;
        }
    }

    return maxFreq;
};
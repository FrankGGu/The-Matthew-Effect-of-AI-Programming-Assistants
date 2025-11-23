var maxSubarrayLength = function(nums, k) {
    let left = 0;
    let maxLen = 0;
    const freq = new Map();

    for (let right = 0; right < nums.length; right++) {
        const num = nums[right];
        freq.set(num, (freq.get(num) || 0) + 1);

        while (freq.get(num) > k) {
            const leftNum = nums[left];
            freq.set(leftNum, freq.get(leftNum) - 1);
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};
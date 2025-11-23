var longestNiceSubarray = function(nums) {
    let left = 0, maxLen = 0, mask = 0;
    for (let right = 0; right < nums.length; right++) {
        while ((mask & nums[right]) !== 0) {
            mask ^= nums[left];
            left++;
        }
        mask |= nums[right];
        maxLen = Math.max(maxLen, right - left + 1);
    }
    return maxLen;
};
var longestNiceSubarray = function(nums) {
    let left = 0;
    let currentAnd = 0;
    let maxLength = 0;

    for (let right = 0; right < nums.length; right++) {
        while ((currentAnd & nums[right]) !== 0) {
            currentAnd ^= nums[left];
            left++;
        }
        currentAnd |= nums[right];
        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};
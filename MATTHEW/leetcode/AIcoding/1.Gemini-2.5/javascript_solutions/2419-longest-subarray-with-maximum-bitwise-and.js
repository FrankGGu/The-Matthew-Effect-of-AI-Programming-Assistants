var longestSubarray = function(nums) {
    let maxVal = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    let maxLen = 0;
    let currentLen = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === maxVal) {
            currentLen++;
        } else {
            maxLen = Math.max(maxLen, currentLen);
            currentLen = 0;
        }
    }
    maxLen = Math.max(maxLen, currentLen); // Check for the last sequence

    return maxLen;
};
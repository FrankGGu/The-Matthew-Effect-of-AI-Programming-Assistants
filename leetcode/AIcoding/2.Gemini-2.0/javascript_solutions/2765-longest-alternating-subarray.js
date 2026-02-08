var longestAlternatingSubarray = function(nums, threshold) {
    let maxLen = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > threshold || nums[i] % 2 !== 0) continue;
        let currLen = 1;
        for (let j = i + 1; j < nums.length; j++) {
            if (nums[j] > threshold || nums[j] % 2 === nums[j - 1] % 2) break;
            currLen++;
        }
        maxLen = Math.max(maxLen, currLen);
    }
    return maxLen;
};
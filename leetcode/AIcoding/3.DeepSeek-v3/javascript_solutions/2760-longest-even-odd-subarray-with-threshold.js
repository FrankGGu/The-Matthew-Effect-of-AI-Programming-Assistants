var longestAlternatingSubarray = function(nums, threshold) {
    let maxLen = 0;
    let currentLen = 0;
    let n = nums.length;

    for (let i = 0; i < n; i++) {
        if (nums[i] % 2 === 0 && nums[i] <= threshold) {
            currentLen = 1;
            maxLen = Math.max(maxLen, currentLen);
            for (let j = i + 1; j < n; j++) {
                if (nums[j] <= threshold && nums[j] % 2 !== nums[j - 1] % 2) {
                    currentLen++;
                    maxLen = Math.max(maxLen, currentLen);
                } else {
                    break;
                }
            }
        }
    }

    return maxLen;
};
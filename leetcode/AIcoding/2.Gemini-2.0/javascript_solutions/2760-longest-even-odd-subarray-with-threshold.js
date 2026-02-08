var longestEvenOddSubarray = function(nums, threshold) {
    let maxLen = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] % 2 === 0 && nums[i] <= threshold) {
            let currentLen = 1;
            for (let j = i + 1; j < nums.length; j++) {
                if (nums[j] <= threshold && nums[j] % 2 !== nums[j - 1] % 2) {
                    currentLen++;
                } else {
                    break;
                }
            }
            maxLen = Math.max(maxLen, currentLen);
        }
    }
    return maxLen;
};
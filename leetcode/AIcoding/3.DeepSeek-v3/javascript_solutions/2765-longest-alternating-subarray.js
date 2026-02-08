var alternatingSubarray = function(nums) {
    let maxLen = -1;
    for (let i = 0; i < nums.length; i++) {
        let currentLen = 1;
        for (let j = i + 1; j < nums.length; j++) {
            if (nums[j] - nums[j - 1] === Math.pow(-1, (j - i - 1))) {
                currentLen++;
                maxLen = Math.max(maxLen, currentLen);
            } else {
                break;
            }
        }
    }
    return maxLen >= 2 ? maxLen : -1;
};
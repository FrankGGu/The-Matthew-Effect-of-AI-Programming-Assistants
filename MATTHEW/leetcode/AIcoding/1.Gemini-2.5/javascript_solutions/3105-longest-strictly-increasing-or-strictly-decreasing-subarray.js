var longestStrictlyIncreasingOrStrictlyDecreasingSubarray = function(nums) {
    const n = nums.length;
    if (n <= 1) {
        return n;
    }

    let maxLen = 1;
    let incLen = 1;
    let decLen = 1;

    for (let i = 1; i < n; i++) {
        if (nums[i] > nums[i - 1]) {
            incLen++;
            decLen = 1;
        } else if (nums[i] < nums[i - 1]) {
            decLen++;
            incLen = 1;
        } else { // nums[i] === nums[i-1]
            incLen = 1;
            decLen = 1;
        }
        maxLen = Math.max(maxLen, incLen, decLen);
    }

    return maxLen;
};
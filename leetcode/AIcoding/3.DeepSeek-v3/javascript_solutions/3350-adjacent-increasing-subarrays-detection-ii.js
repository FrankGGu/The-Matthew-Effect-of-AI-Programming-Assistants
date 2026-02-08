var canDivideIntoSubsequences = function(nums, K) {
    let maxFreq = 0;
    let current = 1;

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] === nums[i - 1]) {
            current++;
            maxFreq = Math.max(maxFreq, current);
        } else {
            current = 1;
        }
    }
    maxFreq = Math.max(maxFreq, current);

    return nums.length >= maxFreq * K;
};
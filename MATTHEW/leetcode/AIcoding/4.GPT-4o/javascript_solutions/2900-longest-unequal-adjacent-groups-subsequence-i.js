var longestUnequalSubsequence = function(nums) {
    let n = nums.length;
    if (n === 0) return 0;

    let longest = 1, currentLength = 1;

    for (let i = 1; i < n; i++) {
        if (nums[i] !== nums[i - 1]) {
            currentLength++;
        } else {
            longest = Math.max(longest, currentLength);
            currentLength = 1;
        }
    }

    longest = Math.max(longest, currentLength);
    return longest;
};
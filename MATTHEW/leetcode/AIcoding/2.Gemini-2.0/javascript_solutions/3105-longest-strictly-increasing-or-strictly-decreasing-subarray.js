var longestSubsequence = function(nums) {
    let n = nums.length;
    if (n <= 1) return n;

    let maxLength = 1;
    let increasingLength = 1;
    let decreasingLength = 1;

    for (let i = 1; i < n; i++) {
        if (nums[i] > nums[i - 1]) {
            increasingLength++;
            decreasingLength = 1;
        } else if (nums[i] < nums[i - 1]) {
            decreasingLength++;
            increasingLength = 1;
        } else {
            increasingLength = 1;
            decreasingLength = 1;
        }

        maxLength = Math.max(maxLength, increasingLength, decreasingLength);
    }

    return maxLength;
};
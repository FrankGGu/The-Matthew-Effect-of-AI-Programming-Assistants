var findLengthOfLCIS = function(nums) {
    if (nums.length === 0) return 0;
    let maxLength = 1, currentLength = 1;

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] > nums[i - 1]) {
            currentLength++;
        } else {
            maxLength = Math.max(maxLength, currentLength);
            currentLength = 1;
        }
    }

    return Math.max(maxLength, currentLength);
};
function longestStrictSubarray(nums) {
    if (nums.length < 2) return nums.length;

    let maxLength = 1;
    let currentLength = 1;

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] > nums[i - 1]) {
            currentLength++;
        } else if (nums[i] < nums[i - 1]) {
            currentLength++;
        } else {
            currentLength = 1;
        }
        maxLength = Math.max(maxLength, currentLength);
    }

    return maxLength;
}
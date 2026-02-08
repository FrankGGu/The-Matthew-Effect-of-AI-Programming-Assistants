function findLongestEqualSubarray(nums) {
    let maxLength = 0, currentLength = 1;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] === nums[i - 1]) {
            currentLength++;
        } else {
            maxLength = Math.max(maxLength, currentLength);
            currentLength = 1;
        }
    }
    maxLength = Math.max(maxLength, currentLength);
    return maxLength;
}
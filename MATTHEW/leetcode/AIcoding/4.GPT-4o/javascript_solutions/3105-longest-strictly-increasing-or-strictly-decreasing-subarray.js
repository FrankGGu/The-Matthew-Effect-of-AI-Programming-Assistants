var longestAlternatingSubarray = function(nums) {
    let maxLength = 1, currentLength = 1;
    for (let i = 1; i < nums.length; i++) {
        if ((nums[i] > nums[i - 1] && currentLength % 2 === 1) || 
            (nums[i] < nums[i - 1] && currentLength % 2 === 0)) {
            currentLength++;
        } else {
            maxLength = Math.max(maxLength, currentLength);
            currentLength = 2;
        }
    }
    return Math.max(maxLength, currentLength);
};
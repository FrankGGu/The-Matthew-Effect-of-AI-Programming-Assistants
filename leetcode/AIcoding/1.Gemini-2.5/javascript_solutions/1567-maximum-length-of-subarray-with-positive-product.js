var getMaxLen = function(nums) {
    let maxLength = 0;
    let currentPos = 0; // length of longest subarray ending at current position with positive product
    let currentNeg = 0; // length of longest subarray ending at current position with negative product

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 0) {
            currentPos = 0;
            currentNeg = 0;
        } else if (nums[i] > 0) {
            currentPos++;
            currentNeg = currentNeg > 0 ? currentNeg + 1 : 0;
        } else { // nums[i] < 0
            let prevPos = currentPos; // Store currentPos before it's updated
            currentPos = currentNeg > 0 ? currentNeg + 1 : 0;
            currentNeg = prevPos + 1;
        }
        maxLength = Math.max(maxLength, currentPos);
    }

    return maxLength;
};
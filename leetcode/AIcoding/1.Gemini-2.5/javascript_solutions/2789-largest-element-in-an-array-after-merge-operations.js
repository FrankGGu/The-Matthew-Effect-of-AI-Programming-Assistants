var maxArrayValue = function(nums) {
    let maxVal = 0;
    // Initialize currentSum with the rightmost element.
    // The problem constraints state that nums.length is at least 1.
    let currentSum = nums[nums.length - 1]; 

    // The rightmost element itself is a candidate for the maximum value.
    maxVal = currentSum;

    // Iterate from the second to last element down to the first.
    for (let i = nums.length - 2; i >= 0; i--) {
        // If the current element nums[i] is less than or equal to the currentSum
        // (which represents the sum of elements to its right that could be merged),
        // then nums[i] can be merged into currentSum.
        if (nums[i] <= currentSum) {
            currentSum += nums[i];
        } else {
            // If nums[i] is greater than currentSum, it cannot be merged with the block
            // to its right (represented by currentSum).
            // In this case, currentSum represents a finalized block.
            // We update maxVal with this finalized sum if it's larger.
            maxVal = Math.max(maxVal, currentSum); 
            // Start a new block with nums[i] as it cannot merge with the previous one.
            currentSum = nums[i];
        }
    }

    // After the loop finishes, currentSum holds the value of the leftmost block
    // (which might be a single element or a sum of merged elements).
    // This last block also needs to be compared with maxVal.
    maxVal = Math.max(maxVal, currentSum);

    return maxVal;
};
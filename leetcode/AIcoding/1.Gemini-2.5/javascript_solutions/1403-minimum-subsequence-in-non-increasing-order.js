var minSubsequence = function(nums) {
    nums.sort((a, b) => b - a); // Sort in non-increasing order

    let totalSum = 0;
    for (let i = 0; i < nums.length; i++) {
        totalSum += nums[i];
    }

    let currentSubsequenceSum = 0;
    let result = [];

    for (let i = 0; i < nums.length; i++) {
        currentSubsequenceSum += nums[i];
        result.push(nums[i]);

        // Check if the sum of the current subsequence is strictly greater
        // than the sum of the remaining elements.
        // This is equivalent to currentSubsequenceSum * 2 > totalSum
        if (currentSubsequenceSum > totalSum - currentSubsequenceSum) {
            return result;
        }
    }

    return result; // Should not be reached for valid inputs as a solution always exists
};
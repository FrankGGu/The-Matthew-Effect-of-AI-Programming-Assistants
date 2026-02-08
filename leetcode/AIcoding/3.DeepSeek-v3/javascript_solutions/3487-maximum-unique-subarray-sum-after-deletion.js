var maximumUniqueSubarray = function(nums) {
    let maxSum = 0;
    let currentSum = 0;
    let start = 0;
    const seen = new Set();

    for (let end = 0; end < nums.length; end++) {
        while (seen.has(nums[end])) {
            currentSum -= nums[start];
            seen.delete(nums[start]);
            start++;
        }
        seen.add(nums[end]);
        currentSum += nums[end];
        maxSum = Math.max(maxSum, currentSum);
    }

    return maxSum;
};
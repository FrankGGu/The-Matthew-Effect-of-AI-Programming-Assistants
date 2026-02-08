var maximumUniqueSubarray = function(nums) {
    let left = 0;
    let right = 0;
    let sum = 0;
    let maxSum = 0;
    const seen = new Set();

    while (right < nums.length) {
        while (seen.has(nums[right])) {
            seen.delete(nums[left]);
            sum -= nums[left];
            left++;
        }

        seen.add(nums[right]);
        sum += nums[right];
        maxSum = Math.max(maxSum, sum);
        right++;
    }

    return maxSum;
};
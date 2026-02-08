var minScore = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;

    // Option 1: Remove the two smallest elements
    // The effective range becomes nums[2] to nums[n-1]
    const score1 = nums[n - 1] - nums[2];

    // Option 2: Remove the smallest and the largest element
    // The effective range becomes nums[1] to nums[n-2]
    const score2 = nums[n - 2] - nums[1];

    // Option 3: Remove the two largest elements
    // The effective range becomes nums[0] to nums[n-3]
    const score3 = nums[n - 3] - nums[0];

    return Math.min(score1, score2, score3);
};
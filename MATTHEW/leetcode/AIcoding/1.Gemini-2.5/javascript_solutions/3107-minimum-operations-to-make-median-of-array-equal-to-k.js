var minOperationsToMakeMedianK = function(nums, k) {
    nums.sort((a, b) => a - b);

    const n = nums.length;
    const medianIndex = Math.floor(n / 2);
    let operations = 0;

    // The element at the median index must become k.
    // Calculate operations for this change.
    operations += Math.abs(nums[medianIndex] - k);

    // For elements to the left of the median, they must be less than or equal to k.
    // If any element nums[i] (i < medianIndex) is greater than k, it must be decreased to k.
    // The cost is nums[i] - k.
    for (let i = 0; i < medianIndex; i++) {
        if (nums[i] > k) {
            operations += (nums[i] - k);
        }
    }

    // For elements to the right of the median, they must be greater than or equal to k.
    // If any element nums[i] (i > medianIndex) is less than k, it must be increased to k.
    // The cost is k - nums[i].
    for (let i = medianIndex + 1; i < n; i++) {
        if (nums[i] < k) {
            operations += (k - nums[i]);
        }
    }

    return operations;
};
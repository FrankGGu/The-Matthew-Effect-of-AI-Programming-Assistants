var minDifference = function(nums) {
    const n = nums.length;

    if (n <= 4) {
        return 0;
    }

    nums.sort((a, b) => a - b);

    let minDiff = Infinity;

    // Case 1: Change the three largest elements
    // The remaining elements are nums[0]...nums[n-4]
    minDiff = Math.min(minDiff, nums[n - 4] - nums[0]);

    // Case 2: Change the two largest and one smallest element
    // The remaining elements are nums[1]...nums[n-3]
    minDiff = Math.min(minDiff, nums[n - 3] - nums[1]);

    // Case 3: Change the one largest and two smallest elements
    // The remaining elements are nums[2]...nums[n-2]
    minDiff = Math.min(minDiff, nums[n - 2] - nums[2]);

    // Case 4: Change the three smallest elements
    // The remaining elements are nums[3]...nums[n-1]
    minDiff = Math.min(minDiff, nums[n - 1] - nums[3]);

    return minDiff;
};
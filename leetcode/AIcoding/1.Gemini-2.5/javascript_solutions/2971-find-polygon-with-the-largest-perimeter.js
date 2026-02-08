var largestPerimeter = function(nums) {
    nums.sort((a, b) => a - b);

    let currentPerimeter = 0;
    for (let i = 0; i < nums.length; i++) {
        currentPerimeter += nums[i];
    }

    for (let i = nums.length - 1; i >= 2; i--) {
        // For a polygon to be formed, the longest side must be strictly less than the sum of all other sides.
        // In our sorted array, nums[i] is the current longest side being considered.
        // currentPerimeter - nums[i] is the sum of all other sides in the current set.
        if (currentPerimeter - nums[i] > nums[i]) {
            // If the condition is met, this is the largest possible perimeter
            // because we are iterating from the largest possible set of sides downwards.
            return currentPerimeter;
        }
        // If the condition is not met, nums[i] is too long to form a polygon
        // with the current set of sides. We remove nums[i] from consideration
        // by subtracting it from the currentPerimeter and try with the remaining
        // (smaller) set of sides.
        currentPerimeter -= nums[i];
    }

    // If no polygon can be formed with at least 3 sides, return -1.
    return -1;
};
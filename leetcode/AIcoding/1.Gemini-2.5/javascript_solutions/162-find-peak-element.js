var findPeakElement = function(nums) {
    let left = 0;
    let right = nums.length - 1;

    while (left < right) {
        let mid = Math.floor(left + (right - left) / 2);
        if (nums[mid] < nums[mid + 1]) {
            // We are on an increasing slope, a peak must be to the right
            left = mid + 1;
        } else {
            // We are on a decreasing slope or at a peak
            // A peak must be at or to the left of mid
            right = mid;
        }
    }

    // When left == right, we have found a peak element
    return left;
};
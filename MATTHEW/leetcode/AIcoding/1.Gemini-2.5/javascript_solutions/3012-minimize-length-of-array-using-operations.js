var minimumLength = function(nums) {
    let left = 0;
    let right = nums.length - 1;

    while (left < right && nums[left] === nums[right]) {
        const val = nums[left];

        // Remove prefix elements equal to val
        while (left <= right && nums[left] === val) {
            left++;
        }

        // Remove suffix elements equal to val
        while (left <= right && nums[right] === val) {
            right--;
        }
    }

    // The remaining length is right - left + 1.
    // If left > right, it means all elements were removed, resulting in a length of 0.
    return right - left + 1;
};
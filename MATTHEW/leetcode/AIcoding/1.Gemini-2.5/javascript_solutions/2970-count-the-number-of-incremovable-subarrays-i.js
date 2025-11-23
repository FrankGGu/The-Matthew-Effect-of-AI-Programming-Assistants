var incremovableSubarrays = function(nums) {
    const n = nums.length;
    let count = 0;

    for (let i = 0; i < n; i++) { // Start index of the subarray to remove
        for (let j = i; j < n; j++) { // End index of the subarray to remove

            let isIncremovable = true;

            // Check the prefix part: nums[0...i-1]
            for (let k = 0; k < i - 1; k++) {
                if (nums[k] >= nums[k+1]) {
                    isIncremovable = false;
                    break;
                }
            }
            if (!isIncremovable) {
                continue;
            }

            // Check the suffix part: nums[j+1...n-1]
            for (let k = j + 1; k < n - 1; k++) {
                if (nums[k] >= nums[k+1]) {
                    isIncremovable = false;
                    break;
                }
            }
            if (!isIncremovable) {
                continue;
            }

            // Check the connection between the prefix and suffix parts
            // This condition applies only if both prefix and suffix exist
            if (i > 0 && j < n - 1) {
                if (nums[i-1] >= nums[j+1]) {
                    isIncremovable = false;
                }
            }

            if (isIncremovable) {
                count++;
            }
        }
    }

    return count;
};
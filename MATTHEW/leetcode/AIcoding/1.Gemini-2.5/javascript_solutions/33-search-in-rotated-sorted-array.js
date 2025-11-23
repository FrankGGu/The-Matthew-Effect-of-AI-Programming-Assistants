var search = function(nums, target) {
    let left = 0;
    let right = nums.length - 1;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);

        if (nums[mid] === target) {
            return mid;
        }

        // Check if the left half is sorted
        if (nums[left] <= nums[mid]) {
            // If target is within the sorted left half
            if (nums[left] <= target && target < nums[mid]) {
                right = mid - 1;
            } else {
                // Target is in the right half
                left = mid + 1;
            }
        } 
        // Otherwise, the right half must be sorted
        else {
            // If target is within the sorted right half
            if (nums[mid] < target && target <= nums[right]) {
                left = mid + 1;
            } else {
                // Target is in the left half
                right = mid - 1;
            }
        }
    }

    return -1;
};
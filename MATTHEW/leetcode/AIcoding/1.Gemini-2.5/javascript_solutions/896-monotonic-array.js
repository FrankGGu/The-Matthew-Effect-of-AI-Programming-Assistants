var isMonotonic = function(nums) {
    if (nums.length <= 2) {
        return true;
    }

    let isIncreasing = false;
    let isDecreasing = false;

    let i = 1;
    while (i < nums.length && nums[i] === nums[i-1]) {
        i++;
    }

    if (i === nums.length) {
        return true; // All elements are the same
    }

    if (nums[i] > nums[i-1]) {
        isIncreasing = true;
    } else {
        isDecreasing = true;
    }

    for (let j = i + 1; j < nums.length; j++) {
        if (isIncreasing) {
            if (nums[j] < nums[j-1]) {
                return false;
            }
        } else if (isDecreasing) {
            if (nums[j] > nums[j-1]) {
                return false;
            }
        }
    }

    return true;
};
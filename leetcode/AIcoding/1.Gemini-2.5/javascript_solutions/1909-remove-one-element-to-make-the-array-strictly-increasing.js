function isStrictlyIncreasingWithSkip(arr, skipIndex) {
    let prev = -Infinity;
    for (let i = 0; i < arr.length; i++) {
        if (i === skipIndex) {
            continue;
        }
        if (arr[i] <= prev) {
            return false;
        }
        prev = arr[i];
    }
    return true;
}

var canBeIncreasing = function(nums) {
    let violationCount = 0;
    let violationIndex = -1;

    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] >= nums[i+1]) {
            violationCount++;
            violationIndex = i;
        }
    }

    if (violationCount === 0) {
        return true;
    }

    if (violationCount === 1) {
        if (isStrictlyIncreasingWithSkip(nums, violationIndex)) {
            return true;
        }

        if (isStrictlyIncreasingWithSkip(nums, violationIndex + 1)) {
            return true;
        }

        return false;
    }

    return false;
};
var countFairPairs = function(nums, lower, upper) {
    nums.sort((a, b) => a - b);
    let count = 0;

    for (let i = 0; i < nums.length; i++) {
        let left = i + 1;
        let right = nums.length - 1;
        let lowerBound = -1;
        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            if (nums[i] + nums[mid] >= lower) {
                lowerBound = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        left = i + 1;
        right = nums.length - 1;
        let upperBound = -1;
        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            if (nums[i] + nums[mid] <= upper) {
                upperBound = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (lowerBound !== -1 && upperBound !== -1 && lowerBound <= upperBound) {
            count += upperBound - lowerBound + 1;
        }
    }

    return count;
};
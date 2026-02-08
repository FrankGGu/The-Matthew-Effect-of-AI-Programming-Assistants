var countFairPairs = function(nums, lower, upper) {
    nums.sort((a, b) => a - b);
    let count = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        const left = lower - nums[i];
        const right = upper - nums[i];

        let lowerBound = i + 1;
        let upperBound = n - 1;
        let start = -1;
        let end = -1;

        // Find the first index where nums[j] >= left
        let low = i + 1;
        let high = n - 1;
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (nums[mid] >= left) {
                start = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        // Find the last index where nums[j] <= right
        low = i + 1;
        high = n - 1;
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (nums[mid] <= right) {
                end = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        if (start !== -1 && end !== -1 && start <= end) {
            count += end - start + 1;
        }
    }

    return count;
};